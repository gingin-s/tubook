class BooksController < ApplicationController
  def new
    @user = User.find(current_user.id)
  end

  def create
  end
end
