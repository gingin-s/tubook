class ChatMessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @chat_message = @room.chat_messages.create(message_params)
    RoomChannel.broadcast_to @room, {message: @chat_message.template, id: @chat_message.user_id }
  end

  private
  def message_params
    params.require(:chat_message).permit(:text).merge(user_id: current_user.id.to_s)
  end

  
end
