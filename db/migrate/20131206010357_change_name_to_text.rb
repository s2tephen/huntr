class ChangeNameToText < ActiveRecord::Migration
  def change
    change_column :listings, :name, :text
  end
end
