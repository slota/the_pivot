Rails.application.routes.draw do

  get '/notification' => 'notification#create'

  namespace :admin do
    resources :venues
  end
  #
  root to: "pages#home"

  resources :cart_concerts, only: [:create, :destroy, :update]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :orders, only: [:index, :create, :show, :new]
  resources :concerts
  resources :venues, only: [:index, :new, :create]

  get '/about', to: 'pages#about'
  post '/', to: 'pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/cart', to: 'cart_concerts#index'

  get '/:venue/edit', to: 'venues#edit', as: :edit_venue
  get '/:venue', to: 'venues#show', as: :venue
  patch '/:venue', to: 'venues#update'
  put '/:venue', to: 'venues#update'

  namespace :admin do
    resources :venues
    resources :cart_concerts, only: [:create, :destroy, :update]
    resources :users, only: [:new, :create, :show, :edit, :update]
    resources :orders, only: [:index, :create, :show, :new]
    resources :concerts
    namespace :venues do
      resources :concerts, only: [:show]
    end
  end

  namespace :venues, path: "venue" do
    resources :managers, only: [:create, :destroy]
  end

  namespace :venues, path: ":venue", as: :venue do
    get '/:concert', to: 'concert#show', as: :concert
    delete '/:concert', to: 'concert#destroy'
    post '/concerts', to: 'concert#create', as: :concerts
    get '/concerts/new', to: 'concert#new', as: :new_concert
    get '/:concert/edit', to: 'concert#edit', as: :edit_concert
    patch '/:concert', to: 'concert#update', as: :update_concert
    resources :managers, only: [:create, :destroy]
  end

end
