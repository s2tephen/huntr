class ChangeTimeToStartEnd < ActiveRecord::Migration
  def change
    remove_column :listings, :time
    add_column :listings, :start_time, :datetime
    add_column :listings, :end_time, :datetime
  end
end
