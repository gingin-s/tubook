class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:new, :create, :update]
  def new
    @note = Note.new
    set_notes
    if current_user.id == @book.user.id
      render 'books/show.js.erb'
    else
      redirect_to root_path
    end
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      @note = Note.new
      set_notes
      render 'books/show.js.erb'
    end
  end

  def edit
    @note = Note.find(params[:id])
    @book = @note.book
    if current_user.id == @book.user.id
      render 'edit.js.erb'
    else
      redirect_to root_path
    end
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      @note = Note.new
      set_notes
      render 'books/show.js.erb'
    end
  end

  def destroy
    note = Note.find(params[:id])
    @book = note.book
    if current_user.id == note.user_id
      note.destroy
      @note = Note.new
      set_notes
      render 'books/show.js.erb'
    end
  end

  private

  def note_params
    params.require(:note).permit(:text, :video_time).merge(book_id: params[:book_id], user_id: current_user.id)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_notes
    @notes = @book.notes.order(video_time: 'ASC')
  end
end
