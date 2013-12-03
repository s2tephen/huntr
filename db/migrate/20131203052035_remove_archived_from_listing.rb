class RemoveArchivedFromListing < ActiveRecord::Migration
  def change
    remove_column :listings, :archived, :boolean
  end
end
