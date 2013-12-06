class AddReadToFavorite < ActiveRecord::Migration
  def change
    add_column :favorites, :read, :boolean
  end
end
