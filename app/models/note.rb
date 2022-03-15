class Note < ApplicationRecord
  belongs_to :user
  belongs_to :book


  with_options presence: true do
    validates :text, length: { maximum: 300 }
    validates :video_time
    validates :user_id
    validates :video_time
  end
end
