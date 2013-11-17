class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Only allow mit.edu addresses
  validates_format_of :email, :with => /\A([^@\s]+)@([A-z].)?(mit.edu)\Z/, :on => :create

  
  def display_archive
  	@listings=Listing.where(:archived => true)
  end

  def display_all
  	@listings=Listing.where(:archived => false)
  end
end
