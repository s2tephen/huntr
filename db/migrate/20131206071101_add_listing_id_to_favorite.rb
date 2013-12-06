class AddListingIdToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :listing_id, :integer
  end
end
