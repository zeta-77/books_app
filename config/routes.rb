Rails.application.routes.draw do
  root to: 'books#index'
  resources :books
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations"
  }
  resource :profile, only: [:show]
  resources :users, only: [:index, :show]
  resources :follow_users, only: [:create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
