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
  resources :products
end
