# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'mail'

Mail.defaults do
  retriever_method :imap, { :address    => 'imap.gmail.com',
                            :port       => 993,
                            :user_name  => ENV['GMAIL_USERNAME'],
                            :password   => ENV['GMAIL_PASSWORD'],
                            :enable_ssl => true }
end

# TODO: update this any time Listing.fetch is updated
puts 'Seeding db (fetching all mail) — this could take a while!'

Mail.all.each do |m|
  if m.sender == 'eecs-jobs-announce-bounces@lists.csail.mit.edu' # only accept emails from mailman list
    Listing.find_or_create_by(name: m.subject[21..-1]) do |l|
      puts '  ' + l.name
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

      if is_event
        # round to next year if date has passed
        if DateTime.parse(date) < Time.now
          date = (DateTime.parse(date) + 1.year).to_date.to_s
        end

        # dat regex — returns two groupings: start time and (optionally) end time
        time = l.name.match(/(?<=, )(\d{1,2}(?!\/)(?::\d{2})?(?!\d)\s?(?:am|pm)?)(\s?-\s?\d{1,2}(?::\d{2})?(?!\d)\s?(?:am|pm)?)?/i)
        unless time.nil?
          if time[2].nil? # start time only
            l.start_time = DateTime.parse(date + ' ' + time[1], :datetime)
            l.end_time = l.start_time + 1.hour # default to 1 hour
          else # end time specified
            cleaned_end = time[2].split('-')[1].lstrip # remove leading hyphen/whitespace
            l.end_time = DateTime.parse(date + ' ' + cleaned_end, :datetime)
            if time[1].match(/am|pm/i).nil?
              l.start_time = DateTime.parse(date + ' ' + time[1] + cleaned_end.match(/am|pm/i).to_s, :datetime) # e.g. 1-2pm
            else
              l.start_time = DateTime.parse(date + ' ' + time[1], :datetime) # e.g. 11am-1pm
            end
          end
          # timezone shift
          l.start_time += 5.hours
          l.end_time += 5.hours
          puts '    start_time: ' + l.start_time.to_s
          puts '    end_time: ' + l.end_time.to_s
        end
      end

      l.updated_at = m.date # use date/time of email

      begin
        l.body = m.parts[0].parts[0].decoded
      rescue => e
        puts 'error in email: ' + l.name # error message
      end

      # TODO: category
      # TODO: food
    end
  end
end