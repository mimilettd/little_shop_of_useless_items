Rails.application.routes.draw do

  root to: 'home#index'

  resources :stores, only: [:index, :show, :new, :create] do
    resources :items, only: [:index, :show]
  end

  resources :categories, only: [:index]


  resources :orders, only: [:index, :show, :create, :new]

  resources :users, only: [:new, :create, :edit, :update]

  get "/dashboard", to:'users#show', as: 'dashboard'

  delete "/logout", to: 'sessions#destroy', as: 'logout'
  get "/login", to: 'sessions#new', as: 'login'
  post "/login", to: 'sessions#create'

  get '/auth/twitter',  as: :twitter_login
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get '/password-reset', to: 'reset#show'
  get '/password-confirmation', to: 'confirmation#edit'
  patch '/password-confirmation', to: 'confirmation#update'

  resources :items, only:[:new, :create, :index, :show]

  resource :cart
  get '/:category', to: 'categories#show', param: :slug, as: "category"


  namespace :admin do
    get "/dashboard", to: "users#show", as: "dashboard"
    get '/ordered', to: "orders#ordered"
    get '/paid', to: "orders#paid"
    get '/cancelled', to: "orders#cancelled"
    get '/completed', to: "orders#completed"
    get '/items', to: 'items#index', as: 'items'
    get '/pending_stores', to: 'pending_stores#index'
    resources :orders, only: [:index]
    resources :order_items, only: [:update]
    resources :pending_stores, only: [:show, :update]
    resources :user_roles, only: [:index, :show, :update, :destroy]


    resources :stores, only: [:show, :edit, :update] do
      resources :items, only: [:index, :new, :edit, :update, :create]
    end
  end

  post 'retire' => 'items#retire_item', as: :retire

  post 'paid' => 'orders#change_to_paid', as: :paid
  post 'cancelled' => 'orders#change_to_cancelled', as: :cancelled
  post 'completed' => 'orders#change_to_completed', as: :completed

  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'users#login'
      get '/test', to: 'users#test'
      resources :stores, only: [:index, :show]
      namespace :stores do
        resources :itemized_total, only: [:show]
      end
    end
  end
end
