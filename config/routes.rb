Rails.application.routes.draw do
  root "landing#home"

  get "/help", to: "landing#help"
  get "/about", to: "landing#about"
  get "/contact", to: "landing#contact"

  get 'sessions/new'
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  get "/signup", to: 'users#new'

  resources :cruises

  resources :account_activations, only: :edit
  resources :password_resets, only: [:new, :create, :edit, :update]
  get '/shopping_bag', to: 'shopping_bags#show'
  resources :bag_items, only: [:create, :destroy, :update]
  resources :reservations, except: [:edit, :destroy]
  get   '/reservation/:id/summary',      to: 'reservations#summary',      as: :reservation_summary
  patch 'reservation/:id/payment',       to: 'reservations#payment',      as: :reservation_payment
  get   '/reservation/:id/confirmation', to: 'reservations#confirmation', as: :reservation_confirmation
  get   '/my_reservations',              to: 'reservations#history'
  get   '/contact_us',             to: 'contacts#new'
  resources :contacts, only: :create
end
