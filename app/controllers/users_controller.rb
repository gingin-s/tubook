class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_data
  def index
  end

  def update
    if @user.update_attributes(avatar: params_user_avatar[:avatar])
      redirect_to root_path
    else
      @user = User.find(current_user.id)
      render :index
    end
  end

  private

  def params_user_avatar
    params.require(:user).permit(:avatar)
  end

  def set_user_data
    @user = User.find(current_user.id)
    @books = @user.books.order(created_at: 'DESC').includes(:notes)
    @rooms = @user.rooms.all
  end
end
