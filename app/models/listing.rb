class Listing < ActiveRecord::Base
  searchable do
    text :name, :location, :body
  end
end
