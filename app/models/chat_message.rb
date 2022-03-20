class ChatMessage < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def template
    ApplicationController.renderer.render partial: 'shared/left_message', locals: { message: self }
  end
end
