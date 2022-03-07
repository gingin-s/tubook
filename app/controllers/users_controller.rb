class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
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
end
