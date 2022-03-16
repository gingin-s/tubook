class Book < ApplicationRecord
  has_one :book_user
  has_one :user, through: :book_user
  has_one :book_room
  has_one :room, through: :book_room
  has_many :notes

  validates :title, presence: true
  validates :description, length: { maximum: 300 }
  validates :youtube_id,  presence: true,
                          length: { is: 11, allow_blank: true, message: "URL is not youtube video's URL" }
end
