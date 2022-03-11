class Note < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :text, presence: true
  validates :video_time, presence: true
end
