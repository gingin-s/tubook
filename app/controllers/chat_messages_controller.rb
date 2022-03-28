class ChatMessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    if @chat_message = @room.chat_messages.create(message_params)
      RoomChannel.broadcast_to @room,
                               { leftMessage: @chat_message.left_template, rightMessage: @chat_message.right_template,
                                 id: @chat_message.user_id }
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:text).merge(user_id: current_user.id.to_s)
  end
end
