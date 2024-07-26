Rails.application.routes.draw do
  # Routes for cart functionality
  get 'carts/show'
  post 'carts/add_item', to: 'carts#add_item', as: 'add_item_cart'
  post 'carts/remove_item', to: 'carts#remove_item', as: 'remove_item_cart'
  post 'carts/update_item', to: 'carts#update_item', as: 'update_item_cart'

  # Devise and ActiveAdmin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, skip: [:sessions]
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    get 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
    # delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

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

  # Route for checkout
  resource :checkout, only: [:new, :create] do
    get 'confirmation', on: :collection
  end

  # Route for viewing past orders
  resources :users, only: [] do
    get 'orders', to: 'orders#index'
    get 'order', to: 'orders#show'
  end

  # Route for updating order status
  patch 'orders/:id/update_status', to: 'orders#update_status', as: 'update_order_status'

  # Routes for handling payment success and failure
  get 'orders/payment_success', to: 'orders#payment_success', as: 'payment_success_orders'
  get 'orders/payment_failure', to: 'orders#payment_failure', as: 'payment_failure_orders'
end
