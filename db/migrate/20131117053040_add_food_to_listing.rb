class AddFoodToListing < ActiveRecord::Migration
  def change
  	add_column :listings, :food, :boolean
  end
end
