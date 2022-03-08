class Book < ApplicationRecord
  has_one :book_user
  has_one :user, through: :book_user

  validates :title, presence: true
  validates :youtube_id,  presence: true,
                          length: { is: 11, allow_blank: true, message: "URL is not youtube video's URL"}
end
