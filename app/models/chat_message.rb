class ChatMessage < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :text, presence: true

  def left_template
    ApplicationController.renderer.render partial: 'shared/left_message', locals: { message: self }
  end
  def right_template
    ApplicationController.renderer.render partial: 'shared/right_message', locals: { message: self }
  end
end
