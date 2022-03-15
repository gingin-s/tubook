Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: :update
  resources :rooms, only: [:new, :create, :show] do
    collection do
      post "add_member_to_lists"
    end
  end
  resources :books, only: [:new, :create]
  resources :books, only: [:show, :edit, :update] do
    resources :notes, only: [:create, :update, :new]
  end
  resources :notes, only: [:edit, :destroy]
end
