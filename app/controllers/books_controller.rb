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
    # bookの所属先がuserの場合
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
    # bookの所属先がuserの場合
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
    @notes = @book.notes.order(video_time: 'ASC').includes(:user)
    gon.notes = @notes
    @note = Note.new
    @user = current_user
    @rooms = @user.rooms
    if @book.room
      @room = @book.room
      @chat_messages = @room.chat_messages.includes(:user)
      @chat_message = ChatMessage.new
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
    # bookの所属先がuserの場合
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
    elsif book.destroy
      redirect_to root_path
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
