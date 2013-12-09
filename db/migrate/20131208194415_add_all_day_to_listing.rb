class AddAllDayToListing < ActiveRecord::Migration
  def change
    add_column :listings, :all_day, :boolean
  end
end
