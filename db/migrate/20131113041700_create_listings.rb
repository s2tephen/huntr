class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.datetime :time
      t.string :location
      t.text :body
      t.string :category
      t.boolean :archived

      t.timestamps
    end
  end
end
