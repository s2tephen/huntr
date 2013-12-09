class RemoveFoodFromListing < ActiveRecord::Migration
  def change
    remove_column :listings, :food, :boolean
  end
end
