class AddQueryToListing < ActiveRecord::Migration
  def change
    add_column :listings, :query, :string
  end
end
