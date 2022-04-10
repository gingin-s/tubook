class RoomBooksController < ApplicationController
  include BookArticle

  before_action :authenticate_user!
  before_action :set_user, except: :show
  before_action :set_book, only: [:show, :edit]
  before_action :move_to_index, only: [:show, :edit]

  def new
    @room = Room.find(params[:room_id])
    @url = room_room_books_path(@room)
    @book = Book.new
    render "books/new"
  end

  def create
    @room = Room.find(params[:room_id])
    @book = @room.books.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render "books/new"
    end
  end

  def update
    @room = Room.find(params[:room_id])
    @book = @room.books.find(params[:id])
    if @book.update_attributes(book_update_params)
      redirect_to room_path(@room)
    else
      render "books/edit"
    end
  end

end
