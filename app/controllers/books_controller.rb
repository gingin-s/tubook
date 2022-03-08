class BooksController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def create
    @book = Book.new(user_book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
  end

  private

  def user_book_params
    params.require(:book).permit(:title, :description).merge(user_id: current_user.id, youtube_id: get_youtube_id)
  end

  def get_youtube_id
    url = params.require(:book).permit(:youtube_id)
    url.last(11)
  end
end
