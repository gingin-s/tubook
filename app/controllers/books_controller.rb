class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: :show
  before_action :set_book, only: [:show, :edit]
  before_action :move_to_index, only: [:show, :edit]
  def new
    # bookの所属先がroomの場合
    if params[:room_id]
      @room = Room.find(params[:room_id])
      @url = room_books_path(@room)
    # bookの所属先がroomの場合
    else
      @url = books_path
    end
    @book = Book.new
  end

  def create
    # bookの所属先がroomの場合
    if params[:room_id]
      @room = Room.find(params[:room_id])
      @book = @room.books.new(book_params)
    # bookの所属先がroomの場合
    else
      @book = @user.books.new(book_params)
    end
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    gon.youtube_id = @book.youtube_id
    @notes = @book.notes.order(video_time: 'ASC')
    gon.notes = @notes
    @note = Note.new
    if @book.room
      @room = @book.room
    end
  end

  def edit
    if @book.room
      @room = @book.room
      @url = room_book_path(@room)
    else
      @url = book_path
    end
  end

  def update
    # bookの所属先がroomの場合
    if params[:room_id]
      @room = Room.find(params[:room_id])
      @book = @room.books.find(params[:id])
      if @book.update_attributes(book_update_params)
        redirect_to room_path(@room)
      else
        render :edit
      end
    # bookの所属先がroomの場合
    else
      @book = @user.books.find(params[:id])
      if @book.update_attributes(book_update_params)
        redirect_to root_path
      else
        render :edit
      end
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.room
      room = book.room
      redirect_to room_path(room) if book.destroy
    else
      redirect_to root_path if book.destroy
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
    @rooms = @user.rooms
  end
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description).merge(youtube_id: get_youtube_id)
  end

  def book_update_params
    params.require(:book).permit(:title, :description)
  end



  def move_to_index
    if @book.room
      redirect_to root_path unless  @book.room.users.exists?(current_user.id)
    else
      redirect_to root_path unless current_user.id == @book.user.id
    end
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
