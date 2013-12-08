require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "marking a favorite as read/unread" do
  	@favorite = favorites(:one)

  	# unread favorite gets marked as read
  	@favorite.mark_read
  	assert(@favorite.read, "favorite should be marked as read")

  	# read favorite gets marked as read, should still be read
  	@favorite.mark_read
  	assert(@favorite.read, "favorite should still be marked as read")

  	# read favorite gets marked as unread
  	@favorite.mark_unread
  	assert_not(@favorite.read, "favorite should be marked as unread")

  	# unread favorite gets marked as unread, should still be unread
  	@favorite.mark_unread
  	assert_not(@favorite.read, "favorite should still be marked as unread")
  end
end
