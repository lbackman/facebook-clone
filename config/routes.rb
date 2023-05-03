Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, except: [:new, :create]

  resources :friend_requests, only: [:create, :update, :destroy]
  get 'users/:id/friends', to: 'users#friends', as: :friends

  # Defines the root path route ("/")
  root "users#index"
end
