Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  root to: "users#index"
  resources :users, only: [:update]
  resources :rooms, only: [:new, :create, :show] do
    resources :room_books, only: [:new, :create, :update]
    resources :chat_messages, only: [:index, :create]
    collection do
      post "add_member_to_lists"
    end
    member do
      patch "change_avatar"
      patch "add_member"
      delete "remove_member"
    end
  end
  resources :books, only: [:new, :create]
  resources :books, only: [:show, :edit, :update, :destroy] do
    resources :notes, only: [:create, :update, :new]
  end
  resources :notes, only: [:edit, :destroy]
end
