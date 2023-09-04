Rails.application.routes.draw do
  resources :posts
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
  get "home/users"
end
