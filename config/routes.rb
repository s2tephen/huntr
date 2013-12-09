Huntr::Application.routes.draw do
  devise_for :users
  resources :listings

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => 'listings#index'
  
  match "search_results", to: "listings#search_results", via: :get
  match "favorites", to: "listings#favorites", via: :get
  match "cal", to: "listings#cal", via: :get

  # redirect non-existent pages to root
  get '*path' => redirect('/')

end
