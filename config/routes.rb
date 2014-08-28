Tribalknow::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  post 'settings/:id', :to => 'settings#update', :as=>'settings'
  resources :users
  resource  :account
  resources :searches
  #autocomplete
  get '/autocomplete' => 'searches#autocomplete'


  resources :topics do
    resources :topic_files
    member do
      post :set_icon
    end
  end

  resources :tenants
  resources :public_profiles, only:[:index, :show]
  resources :activities
  resources :approve_users, :only => [ :index ] do
    member do
      post :approve, :reject
    end
  end

  resources :notes
  resources :docs
  get "/docs/*path" => "docs#show"
  
  resources :questions, path_names: { new: 'ask' } do
    collection do
      get 'search'
    end
    resources :answers, path_names: { new: 'new' }
  end
  
  post '/votes' => 'votes#create'

  get '/todo' => 'homes#todo'
  get '/about' => 'homes#about'
  root :to => 'homes#index'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
