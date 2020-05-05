Rails.application.routes.draw do
  devise_for :users
  get "sessions/new"
  root "static_pages#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "category", to: "category#index"
  delete "/deleteitem", to: "line_items#destroy"
  namespace :admin do
    resources :users
    resources :categories
    resources :products
    resources :orders
    resources :orderdetails
    resources :suggests
    resources :statistics, only: :index
  end
  resources :suggests
  resources :static_pages
  resources :product
  resources :line_items
  resources :carts
  resources :items, only: [:create]
  resources :orders
  resources :users
  resources :ratings, only: [:create]
  resources :histories
end
