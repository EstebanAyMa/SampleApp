Rails.application.routes.draw do
  get 'sessions/new'
  root "static_pages#home"
  get "/signup", to: 'users#new'
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :cruises

  resources :account_activations, only: :edit
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/shopping_bag', to: 'shopping_bags#show'
  resources :bag_items, only: [:create, :destroy, :update]
  resources :orders, except: [:edit, :destroy]
  get   '/order/:id/summary',      to: 'orders#summary',      as: :order_summary
  patch 'order/:id/payment',       to: 'orders#payment',      as: :order_payment
  get   '/order/:id/confirmation', to: 'orders#confirmation', as: :order_confirmation
  get   '/my_orders',              to: 'orders#order_history'
  get   '/contact_us',             to: 'contacts#new'
  resources :contacts, only: :create
end

