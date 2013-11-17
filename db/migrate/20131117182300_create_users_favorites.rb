class CreateUsersFavorites < ActiveRecord::Migration
  def change
    create_table :users_favorites, :id => false do |t|
    	t.integer :listing_id
    	t.integer :user_id
    end
  end
end
