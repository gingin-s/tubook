class Room < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  has_many :room_users
  has_many :users, through: :room_users, validate: false
  has_many :book_rooms
  has_many :books, through: :book_rooms
  has_many :chat_messages, dependent: :destroy

  validates :name, presence: true
end
