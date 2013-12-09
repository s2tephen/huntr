# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'mail'
require 'nbayes'

Mail.defaults do
  retriever_method :imap, { :address    => 'imap.gmail.com',
                            :port       => 993,
                            :user_name  => ENV['GMAIL_USERNAME'],
                            :password   => ENV['GMAIL_PASSWORD'],
                            :enable_ssl => true }
end

# TODO: update this any time Listing.fetch is updated
puts 'Seeding db — this could take a while!'

# Naive Bayes classifier
nbayes = NBayes::Base.new
event_vocab = ['talk', 'event', 'panel', 'infosession', 'conference', 'study break', 'speaker']
external_opp_vocab = ['intern', 'interns', 'internship', 'internships', 'externship', 'externships', 'startup',
  'fellowship', 'fellowships', 'job', 'jobs', 'opportunity', 'part-time', 'full-time', 'program', 'apply',
  'application', 'applications', 'developer', 'developers', 'engineer', 'engineers', 'position', 'positions']
campus_opp_vocab = ['UROP', 'UROPs', 'TA', 'TAs', 'grader', 'graders', 'UAP', 'UAPs', 'SuperUROP', 'SuperUROPs',
  'apply', 'application', 'applications']

nbayes.train(event_vocab, 'event')
nbayes.train(external_opp_vocab, 'external')
nbayes.train(campus_opp_vocab, 'campus')

Mail.all.each do |m|
  if m.sender == 'eecs-jobs-announce-bounces@lists.csail.mit.edu' # only accept emails from mailman list
    Listing.find_or_create_by(name: m.subject[21..-1]) do |l|
      puts '-- ' + l.name
      begin
        l.body = m.parts[0].parts[0].decoded
      rescue => e
        puts '   -> error fetching!' # error message for admin logs
      end

      is_event = false # is true if subject contains a valid date
      date = l.name.match(/(?<= )\d{1,2}\/\d{1,2}/).to_s
      if date.empty?
        if l.name.match(/today/i)
          date = Date.today.to_s
          is_event = true
        end
      else
        is_event = true
      end
      puts '   -> date: ' + date unless date.empty?

      if is_event
        # round to next year if date has passed
        if DateTime.parse(date) < Time.now
          date = (DateTime.parse(date) + 1.year).to_date.to_s
        end

        # dat regex — returns two groupings: start time and (optionally) end time
        time = l.name.match(/(?<= )(\d{1,2}(?!\/)(?::\d{2})?(?!\d)\s?(?:am|pm)?)(\s?-\s?\d{1,2}(?::\d{2})?(?!\d)\s?(?:am|pm)?)?/i)
        if time.nil?
          l.start_time = date
          l.end_time = date
          l.all_day = true
        else
          if time[2].nil? # start time only
            l.start_time = DateTime.parse(date + ' ' + time[1], :datetime)
            l.end_time = l.start_time + 1.hour # default to 1 hour
          else # end time specified
            cleaned_end = time[2].split('-')[1].lstrip # remove leading hyphen/whitespace
            if cleaned_end.match(/am|pm/i).nil?
              l.end_time = DateTime.parse(date + ' ' + cleaned_end + 'pm', :datetime) # assume pm when unspecified
            else
              l.end_time = DateTime.parse(date + ' ' + cleaned_end, :datetime)
            end
            if time[1].match(/am|pm/i).nil?
              l.start_time = DateTime.parse(date + ' ' + time[1] + cleaned_end.match(/am|pm/i).to_s, :datetime)
              l.start_time -= 12.hours if l.start_time > l.end_time # e.g. 11-3pm => 11pm-3pm => 11am-3pm
            else
              l.start_time = DateTime.parse(date + ' ' + time[1], :datetime)
            end
          end
          # timezone shift
          l.start_time += 5.hours
          l.end_time += 5.hours
          l.all_day = false
        end
        puts '   -> start_time: ' + l.start_time.strftime("%I:%M%p") unless l.start_time.nil?
        puts '   -> end_time: ' + l.end_time.strftime("%I:%M%p") unless l.end_time.nil?
        puts '   -> all_day: ' + l.all_day.to_s

        # location parsing - very basic
        l.location = l.name.match(/(?<= )[ENW]{0,2}\d{1,3}[A-G]?-\d{3,4}/).to_s
        if l.location.empty? # other location names
          ['Student Center', 'Kresge', 'Walker Memorial', 'Religious Activities Center',
           'Lobby 13', 'MIT Chapel', 'Lobby 10', 'Wong Auditorium', 'Stata'].each do |loc|
              l.location = l.name.match(/#{loc}/).to_s unless l.name.match(/#{loc}/).nil?
          end
        end
        puts '   -> location: ' + l.location unless l.location.empty?
      end

      l.updated_at = m.date # use date/time of email

      # naive bayes classification
      l.category = 'other'
      unless l.name.nil?
        tokens = l.name.gsub(/\W/, ' ').split(/ /)
        result = nbayes.classify(tokens)
        nbayes.train(tokens, result.max_class)
        l.category = result.max_class
        puts '   -> category: ' + l.category
      end
    end
  end
end