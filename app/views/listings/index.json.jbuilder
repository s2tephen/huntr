json.array!(@listings) do |listing|
  json.extract! listing, :name, :time, :location, :body, :category
  json.url listing_url(listing, format: :json)
end
