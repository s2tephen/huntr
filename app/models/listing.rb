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

    Mail.all.each do |e|
      Listing.find_or_create_by(name: e.subject[21..-1]) do |l|
        # TODO: time, location
        l.updated_at = e.date
        l.body = e.parts[0].parts[0].decoded
        # TODO: category
        l.archived = false
        # TODO: food
      end
    end
  end

	def display_archive
		@listings=Listing.where(:archived => true)
	end

	def display_all
		@listings=Listing.where(:archived => false)
	end
end
