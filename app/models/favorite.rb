class Favorite < ActiveRecord::Base
	belongs_to :listing
	belongs_to :user

	 # mark listing as read
	 def mark_read
	  	self.read = true
	  	self.save
	 end
end
