class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def create
    @user = User.find(current_user.id)
    @book = @user.books.new(user_book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_book_params
    params.require(:book).permit(:title, :description).merge(youtube_id: get_youtube_id)
  end

  def get_youtube_id
    url = params[:book][:youtube_id]
    return url if url.blank?

    id_search = url.split('v=')[1]
    return url if id_search.nil?

    id_search.slice(0, 11)
  end
end
