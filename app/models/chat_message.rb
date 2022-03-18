class ChatMessage < ApplicationRecord
  belogs_to :room
  belogs_to :user
end
