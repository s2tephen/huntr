class Listing < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "users_favorites"

  def self.fetch
    require 'date'

    Mail.defaults do
      retriever_method :pop3, { :address    => "pop.gmail.com",
                                :port       => 995,
                                :user_name  => ENV["GMAIL_USERNAME"],
                                :password   => ENV["GMAIL_PASSWORD"],
                                :enable_ssl => true }
    end

    Mail.all.each do |e|
      Listing.find_or_create_by(name: e.subject[21..-1]) do |l|
        # TODO: time, location
        l.updated_at = e.date
        l.body = e.parts[0].parts[0].decoded
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
