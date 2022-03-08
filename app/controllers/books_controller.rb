class BooksController < ApplicationController
  def new
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
  end
end
