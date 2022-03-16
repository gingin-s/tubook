class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @user = User.find(current_user.id)
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    binding.pry
    if @room.save
      redirect_to room_path(@room.id)
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

  def show
    @user = User.find(current_user.id)
    @room = Room.find(params[:id])
    @books = @room.books
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
