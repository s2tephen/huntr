class Listing < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites

  def self.fetch
    require 'date'

    Mail.defaults do
      retriever_method :imap, { :address    => 'imap.gmail.com',
                                :port       => 993,
                                :user_name  => ENV['GMAIL_USERNAME'],
                                :password   => ENV['GMAIL_PASSWORD'],
                                :enable_ssl => true }
    end

    Mail.find keys: ['NOT', 'SEEN'].each do |m|
      if m.sender == 'eecs-jobs-announce-bounces@lists.csail.mit.edu' # only accept emails from mailman list
        Listing.find_or_create_by(name: m.subject[21..-1]) do |l|
          is_event = false # is true if subject contains a valid date
          date = l.name.match(/\d{1,2}\/\d{1,2}/).to_s
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
  end
  
  # method to update listing when Anne send seond email about same thing
  def update_listing
    #TODO: edit the data for listing itself!

    #set read boolean to false if favorited by anyone
    @favorites = Favorite.find_by_listing_id(self.id)
    for favorite in @favorites
      favorite.mark_unread
    end
  end
end
