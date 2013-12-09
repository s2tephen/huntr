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

  test "query listings" do
    #filter by category "urop"
    l = @user.query_listings("urop", "")
    assert_equal(l.count, 1, 'ERROR: query should only return 1 listing')
    assert_equal(l[0].category, "urop", 'ERROR: category should be urop')

    #filter by category "MyString"
    l = @user.query_listings("MyString", "")
    assert_equal(l.count, 2, 'ERROR: query should 2 listings')
    l.each {|x| assert_equal(x.category, "MyString", 'ERROR: category should be MyString')}

    #filter by category "MyString" and search for "MyText2"
    l = @user.query_listings("MyString", "MyText2")
    assert_equal(l.count, 1, 'ERROR: query should only return 1 listing')
    assert_equal(l[0].category, "MyString", 'ERROR: category should be MyString')
  end
end
