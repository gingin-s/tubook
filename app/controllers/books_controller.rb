class BooksController < ApplicationController
  include BookArticle

  before_action :authenticate_user!
  before_action :set_user, except: :show
  before_action :set_book, only: [:show, :edit]
  before_action :move_to_index, only: [:show, :edit]

  def new
    @url = books_path
    @book = Book.new
  end

  def create
    @book = @user.books.new(book_params)
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
      @url = room_room_book_path(@room)
    else
      @url = book_path
    end
  end

  def update
    @book = @user.books.find(params[:id])
    if @book.update_attributes(book_update_params)
      redirect_to root_path
    else
      render :edit
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

end
