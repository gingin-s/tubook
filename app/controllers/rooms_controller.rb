class RoomsController < ApplicationController
  def new
    @user = User.find(current_user.id)
  end
end
