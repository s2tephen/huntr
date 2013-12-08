class Favorite < ActiveRecord::Base
	belongs_to :listing
	belongs_to :user

	 # mark listing as read
	 def mark_read
	  	self.read = true
	  	self.save
	 end

	 # mark listing as unread (called by update from listing)
	 def mark_unread
	  	self.read = false
	  	self.save
	 end
end
