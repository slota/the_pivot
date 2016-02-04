Rails.application.routes.draw do
  get "bluebird" => "pages#bluebird"

  get "admin_bluebird" => "pages#admin_bluebird"

  get "edward" => "pages#edward"

  get "cart" => "pages#cart"

  get "profile" => "pages#profile"

  get "order" => "pages#orders"

  #
  get "platform_admin_venues" => "pages#platform_admin_venues"
  #
  post "notifications/notify" => "notifications#notify"
  post "twilio/voice" => "twilio#voice"
  root to: "pages#home"
  resources :oils, only: [:index, :show], param: :slug
  resources :chips, only: [:index, :show], param: :slug
  resources :cart_chips, only: [:create, :index, :destroy, :update]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :orders, only: [:index, :create, :show, :new]
  namespace :admin do
    # resources :chips, only: [:index, :show, :create, :new, :update, :edit, :destroy]
    resources :venues, only: [:index, :new, :create]
    # resources :dashboard, only: [:index, :show]
    resources :orders, only: [:index, :update]
 end



  get '/:venue', to: 'venues#show', as: :venue
  get '/:venue/:concert', to: 'venue_concert#show', as: :venue_concert

  get '/about', to: 'pages#about'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/cart', to: 'cart_chips#index'
  get '/:slug', to: 'oils#show'
  # get '/:slug', to: redirect('/oils/%{slug}'), as: "oil_name"
end
