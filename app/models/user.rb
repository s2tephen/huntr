class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Only allow mit.edu addresses
  validates_format_of :email, :with => /\A([^@\s]+)@([A-z].)?(mit.edu)\Z/, :on => :create

  has_and_belongs_to_many :favorites, class_name: "Listing", join_table: "users_favorites"
  
  def display_archive
  	@listings=Listing.where(:archived => true)
  end

  def display_all
  	@listings=Listing.where(:archived => false)
  end
end
