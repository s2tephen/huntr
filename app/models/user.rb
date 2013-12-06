class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Only allow mit.edu addresses
  validates_format_of :email, :with => /\A([^@\s]+)@([A-z].)?(mit.edu)\Z/, :on => :create

  has_many :favorites
  has_many :listings, through: :favorites

  #favorites / un-favorites listings
  def favorite(listing)
    #if favorite exists, destroy object
  	if listings.include?(listing)
  		favorites.find_by_listing_id(listing.id).destroy
      save
  	else
    #else create object
  		@fav = Favorite.new(user_id: id, listing_id: listing.id)
      @fav.save
      save
  	end
  end

end
