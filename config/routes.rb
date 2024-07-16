Rails.application.routes.draw do
  get 'carts/show'
  post 'carts/add_item', to: 'carts#add_item', as: 'add_item_cart'
  post 'carts/remove_item', to: 'carts#remove_item', as: 'remove_item_cart'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for static pages
  get '/about', to: 'pages#show', id: 'about'
  get '/contact', to: 'pages#show', id: 'contact'

  # Define the root path route ("/")
  root "products#index"

  # Route for products by category
  get 'categories/:id', to: 'products#category', as: 'category_products'

  # Resources for products
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  # Route for cart
  resource :cart, only: [:show]
end
