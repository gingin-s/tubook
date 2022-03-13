class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :show
  def new
    @book = Book.new
  end

  def create
    @book = @user.books.new(user_book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    move_to_index
    gon.youtube_id = @book.youtube_id
    @notes = @book.notes.order(video_time: 'ASC')
    gon.notes = @notes
    @note = Note.new
  end

  def edit
    @book = Book.find(params[:id])
  end


  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_book_params
    params.require(:book).permit(:title, :description).merge(youtube_id: get_youtube_id)
  end
  
  def move_to_index
    redirect_to root_path unless current_user.id == @book.user.id
  end

  # ULLからyoutube_idを切り出し
  def get_youtube_id
    url = params[:book][:youtube_id]
    return url if url.blank?

    id_search = url.split('v=')[1]
    return url if id_search.nil?

    id_search.slice(0, 11)
  end

end
