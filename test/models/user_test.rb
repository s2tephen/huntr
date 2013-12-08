require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @listing = listings(:one)
    @user = users(:one)
  end

  test "user one favorites and unfavorites listing one" do
  	# listing should not be in user's favorites list
  	assert_not(@user.listings.include?(@listing), 'ERROR: listing should not already be in favorites')

  	# listing should now be added to user's favorites
    assert_difference('@user.listings.count', 1, 'ERROR: listing should be in favorites') do
    	@user.favorite(@listing)
    end

    # listing should be removed from user's favorites
    assert_difference('@user.listings.count', -1, 'ERROR: listing should not already be in favorites') do
    	@user.favorite(@listing)
    end
  end
end
