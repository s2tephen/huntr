class Listing < ActiveRecord::Base

	def display_archive
		@listings=Listing.where(:archived => true)
	end

	def display_all
		@listings=Listing.where(:archived => false)
	end
end
