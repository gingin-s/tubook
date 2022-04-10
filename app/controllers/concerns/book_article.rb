module BookArticle
  extend ActiveSupport::Concern

  def set_user
    @user = User.find(current_user.id)
    @rooms = @user.rooms
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description).merge(youtube_id: GetYoutubeIdServices.url_to_id(params[:book][:youtube_id]))
  end

  def book_update_params
    params.require(:book).permit(:title, :description)
  end

  def move_to_index
    if @book.room
      redirect_to root_path unless @book.room.users.exists?(current_user.id)
    else
      redirect_to root_path unless current_user.id == @book.user.id
    end
  end

end 