Rails.application.routes.draw do
  
  get "static_pages/about"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "static_pages#home"

  #registration
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  #basic login
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  resources :products do
    resources :biddings
  end

  get '/products/:id/select_winner/:product_id', to: 'products#select_winner', as: 'select_winner' 
  put '/products/:id/stop_bidding', to: 'products#stop_bidding', as: 'stop_bidding_product'
  # get "/biddings/:id", to: "biddings#index", as:"biddings"
  # get 'biddings/new/:id', to: 'biddings#new', as: 'new_bidding'
  # get 'biddings/new/:id', to: 'biddings#new', as: 'custom_new_bidding'
  get 'my_biddings', to: 'biddings#my_biddings'
  get 'my_products', to: 'products#my_products'
end
