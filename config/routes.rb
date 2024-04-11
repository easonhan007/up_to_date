Rails.application.routes.draw do
  resources :api_call_records
  resources :post_targets
  resources :settings
  resources :categories
  resources :posts do
    member do 
      post 'add_to_favorites'
      delete 'remove_from_favorites'
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
  root "home#index"
  get "up" => "home#up", as: :rails_health_check
  get "home/users"
  get "home/favorites"
  get "home/cat/:slug", to: 'home#cat', as: 'cat'
end
