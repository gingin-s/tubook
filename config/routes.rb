Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: :update
  resources :books, only: [:new, :create]
  resources :books, only: [:edit] do
    resources :notes, only: :create
  end
end
