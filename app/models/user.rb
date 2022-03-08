class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :book_users
  has_many :books, through: :book_users
  
  validates :avatar, presence: true, on: :update
  validates :nickname,  presence: true,
                        format: { with: /\A[a-zA-Z0-9_]+\z/, allow_blank: true },
                        uniqueness: {case_sensitive: true}
end
