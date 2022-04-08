class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :book_users
  has_many :books, through: :book_users
  has_many :notes
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :chat_messages

  validates :avatar, presence: true, on: :update
  validates :nickname,  presence: true,
                        format: { with: /\A[a-zA-Z0-9_]+\z/, allow_blank: true },
                        uniqueness: true



  def self.load_avatar(user)
    if user.avatar.file
      "https://tubook.s3.amazonaws.com/uploads/user/avatar/#{user.id}/#{user.avatar.identifier}"
    else
      '/assets/default-2ebaf5557392ad8670ddca8292c8e0f57477c605106977892eb415add53ef6a3.png'
  end
end


end
