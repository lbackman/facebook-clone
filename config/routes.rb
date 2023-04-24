Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, except: [:new, :create]
  resources :friend_requests, only: [:index, :show, :create, :update, :destroy]

  # Defines the root path route ("/")
  root "users#index"
end
