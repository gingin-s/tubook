Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: :update
  resources :books, only: [:new, :create]
  resources :books, only: [:show] do
    resources :notes, only: [:create, :update, :new]
  end
  resources :notes, only: [:edit, :destroy]
end
