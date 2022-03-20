class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_room_data, only: [:show, :change_avatar, :add_member, :remove_member]
  before_action :move_to_root, only: [:show, :remove_member, :add_member, :change_avatar]
  def new
    @user = User.find(current_user.id)
    @rooms = @user.rooms
    @new_room = Room.new
  end

  def show
  end

  def create
    @new_room = Room.new(room_params)
    if @new_room.save
      redirect_to room_path(@new_room.id)
    else
      @user = User.find(current_user.id)
      render :new
    end
  end

  def add_member_to_lists
    if User.exists?(nickname: params[:user_name])
      user = User.find_by(nickname: params[:user_name])
      user_img = if user.avatar.file
                   "/uploads/user/avatar/#{user.id}/#{user.avatar.identifier}"
                 else
                   '/assets/default-2ebaf5557392ad8670ddca8292c8e0f57477c605106977892eb415add53ef6a3.png'
                 end
      error_message = "#{params[:user_name]}さんは追加済みです"
      render json: { user_id: user.id, user_name: user.nickname, user_img: user_img, error_message: error_message }
    else
      error_message = "#{params[:user_name]}は存在しません"
      render json: { error_message: error_message, form_value: params[:user_name] }
    end
  end

  def change_avatar
    if @room.update_attributes(avatar: params_room_avatar[:avatar])
      redirect_to room_path(@room)
    else
      @room = Room.find(@room)
      render :index
    end
  end

  def remove_member
    room_user = RoomUser.where(room_id: params[:id]).find_by(user_id: params[:user_id])
    room_user.destroy
    if RoomUser.where(room_id: params[:id]) == []
      Room.find(params[:id]).destroy
      redirect_to root_path
    else
      redirect_to room_path(params[:id])
    end
  end

  def add_member
    if User.exists?(user_name_params)
      user = User.find_by(user_name_params)
      if RoomUser.where(room_id: params[:id]).find_by(user_id: user.id)
        @error_message = "#{user_name_params[:nickname]}さんは追加済みです"
        render :show
      else
        RoomUser.create(room_id: params[:id], user_id: user.id)
        redirect_to room_path(@room.id)
      end
    else
      @error_message = "#{user_name_params[:nickname]}は存在しません"
      @error_message = 'ユーザー名を入力してください' if user_name_params[:nickname].blank?
      render :show
    end
  end

  private

  def set_room_data
    @user = User.find(current_user.id)
    @room = Room.find(params[:id])
    @books = @room.books.order(created_at: 'DESC').includes(:notes)
    @chat_messages = @room.chat_messages.includes(:user)
    @chat_message = ChatMessage.new
  end

  def user_name_params
    params.require(:room).permit(:nickname)
  end

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end

  def params_room_avatar
    params.require(:room).permit(:avatar)
  end

  def move_to_root
    redirect_to root_path unless RoomUser.where(room_id: params[:id]).find_by(user_id: current_user.id)
  end
end
