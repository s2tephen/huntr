require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @listing = listings(:one)
    @user = users(:one)
  end

  test "user one favorites and unfavorites listing one" do
  	# listing should be in user's favorites list
  	assert_not(@user.favorites.include?(@listing), 'ERROR: listing should not already be in favorites')

  	# user favorites listing
    @listing.favorite(@user)
    assert(@user.favorites.include?(@listing), 'ERROR: listing should be in favorites')
    
	# user un-favorites listing
    @listing.favorite(@user)
    assert_not(@user.favorites.include?(@listing), 'ERROR: listing should not already be in favorites')
  end
end
