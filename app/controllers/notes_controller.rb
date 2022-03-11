class NotesController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @note = Note.new
    @notes = @book.notes.order(video_time: "ASC")
    render 'books/edit.js.erb'
  end

  def create
    @book = Book.find(params[:book_id])
    @note = Note.new(note_params)
      if @note.save
        @note = Note.new
        @notes = @book.notes.order(video_time: "ASC")
        render 'books/edit.js.erb'
      end
  end

  def edit
    @note = Note.find(params[:id])
    @book = @note.book
    @notes = @book.notes.order(video_time: "ASC")
    render "edit.js.erb"
  end

  def update
    @book = Book.find(params[:book_id])
    @note = Note.find(params[:id])
    if @note.update(note_params)
      @note = Note.new
      @notes = @book.notes.order(video_time: "ASC")
      render 'books/edit.js.erb'
    end
  end

  def destroy
    note = Note.find(params[:id])
    @book = note.book
    if note.destroy
      @note = Note.new
      @notes = @book.notes.order(video_time: "ASC")
      render 'books/edit.js.erb'
    end
  end


  private
  def note_params
    params.require(:note).permit(:text, :video_time).merge(book_id: params[:book_id], user_id: current_user.id)
  end
end
