Rails.application.routes.draw do
  root to: 'home#index'

  get '/password-reset', to: 'password#new'
  post '/password-confirmation', to: 'password#create'
  get '/password-verification', to: 'password#edit'
  put '/password-update', to: 'password#update'

  resources :stores, only: [:index, :show] do
    resources :items, only: [:index, :show]
  end

  resources :categories, only: [:index]


  resources :orders, only: [:index, :show, :create, :new]

  resources :users, only: [:new, :create, :edit, :update]

  get "/dashboard", to:'users#show', as: 'dashboard'

  delete "/logout", to: 'sessions#destroy', as: 'logout'
  get "/login", to: 'sessions#new', as: 'login'
  post "/login", to: 'sessions#create'

  resources :items, only:[:new, :create, :index, :show]

  resource :cart



  namespace :admin do
    get "/dashboard", to: "users#show", as: "dashboard"
    get '/ordered', to: "orders#ordered"
    get '/paid', to: "orders#paid"
    get '/cancelled', to: "orders#cancelled"
    get '/completed', to: "orders#completed"
    get '/items', to: 'items#index', as: 'items'
    resources :items, only: [:new, :edit, :update, :create]
  end

  post 'retire' => 'items#retire_item', as: :retire

  post 'paid' => 'orders#change_to_paid', as: :paid
  post 'cancelled' => 'orders#change_to_cancelled', as: :cancelled
  post 'completed' => 'orders#change_to_completed', as: :completed

  # get '/:category', to: 'categories#show', param: :slug, as: "category"
end
