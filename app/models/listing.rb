class Listing < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: "users_favorites"
  
  searchable do
    text :name, :location, :body
  end
  
	def display_archive
		@listings=Listing.where(:archived => true)
	end

	def display_all
		@listings=Listing.where(:archived => false)
	end
end
