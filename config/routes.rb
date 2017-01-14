Tribalknow::Application.routes.draw do

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    mount Searchjoy::Engine, at: "/searchjoy"
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  post 'settings/:id', :to => 'settings#update', :as=>'settings'
  
  namespace :admin do
    resources :home
    resources :users
    resources :analytics
    resources :config
    resources :approve_users, :only => [ :index ] do
      member do
        post :approve, :reject
      end
    end
  end

  resources :videos do
    resources :video_attachments
    member do
      get :info
      post :trigger
      post :update_status
    end
  end
  
  resource  :account do
    post :avatar
  end

  resource  :static_site
  resources :searches do
    get 'autocomplete', on: :collection
  end

  get "registration/complete"
  post 'registration/complete', :to => 'registration#update', :as=>'update_registration'

  resources :topics do
    resources :topic_files
    member do
      post :set_icon
      get  :show_history
    end
  end

  resources :tenants
  resources :public_profiles, only:[:index, :show]
  resources :activities

  resources :notes
  resources :docs
  get "/docs/*path" => "docs#show"
  
  resources :questions, path_names: { new: 'ask' } do
    member do
      post :notify
      post :revert
    end
    collection do
      get 'search'
    end
    resources :answers, path_names: { new: 'new' } do
      member do
        post :notify
        post :revert
      end
    end
  end

  # API
  namespace :api do
    resources :search, only: [:index]
    resources :questions, only: [:show]
    resources :answers, only: [:show]
    resources :topics, only: [:show]
  end

  post '/votes' => 'votes#create'

  get '/todo' => 'homes#todo'
  get '/about' => 'homes#about'
  root :to => 'homes#index'

end
