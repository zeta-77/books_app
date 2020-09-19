Rails.application.routes.draw do
  root to: 'books#index'
  resources :books
  devise_for :users
  resources :users, only: [:show]
  get 'profile', action: :show, controller: 'users'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
