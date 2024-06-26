Rails.application.routes.draw do
  resources :api_call_records
  resources :post_targets
  resources :settings
  resources :categories
  resources :posts do
    member do 
      post 'add_to_favorites'
      delete 'remove_from_favorites'
      post 'rewrite_title'
    end
  end
  resources :crawler_records
  resources :crawler_settings do 
    member do
      get 'scrape'
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "up" => "home#up", as: :rails_health_check

  # home
  root "home#index"
  get "home/users"
  get "home/favorites", as: 'favorites'
  get "home/cat/:slug", to: 'home#cat', as: 'cat'

  # api
  post "/api/scrape_all", to: "api#scrape_all"
end
