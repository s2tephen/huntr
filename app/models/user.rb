class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
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
  		@fav = Favorite.new(user_id: id, listing_id: listing.id, read: false)
      @fav.save
      save
  	end
  end

  # method to filter listings by category
  # takes category:string query:string as inputs
  # returns relevant_listings
  def query_listings(category, query)
    @relevant_listings = Listing.all
    if category
      @relevant_listings = @relevant_listings.where(:category => category)
    end
    if query and query.length > 0
      @relevant_listings = @relevant_listings.basic_search(query)
    end
    return @relevant_listings.order(updated_at: :desc)
  end
end
