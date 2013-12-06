class Listing < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "users_favorites"

  def self.fetch
    Mail.defaults do
      retriever_method :pop3, { :address    => "pop.gmail.com",
                                :port       => 995,
                                :user_name  => ENV["GMAIL_USERNAME"],
                                :password   => ENV["GMAIL_PASSWORD"],
                                :enable_ssl => true }
    end

    Mail.all.each do |m|
      Listing.find_or_create_by(name: m.subject[21..-1]) do |l|
        # TODO: time, location
        l.updated_at = m.date
        begin
          l.body = m.parts[0].parts[0].decoded
        rescue => e
          puts 'error in email: ' + l.name # error message
        end
        # TODO: category
        # TODO: food
        # RiCal.Calendar do |ics_file|
          # ics_file.event do |event|
            # event.description = l.name
            # event.dtstart = DateTime.current
            # event.location = "77 Mass Ave"
          # end
        # end
        # l.ics = ics_file
      end
    end
  end

  # action called by favorite button
  # toggles favorite status
	def favorite(user)
		listing = Listing.find(self.id)
		if user.favorites.include?(listing)
			user.favorites.delete(listing)
		else
			user.favorites.append(listing)
		end
	end

end
