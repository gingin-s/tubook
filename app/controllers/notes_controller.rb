class NotesController < ApplicationController
  def index

  end

  def create
    @book = Book.find(params[:book_id])
    @note = Note.new(note_params)
      if @note.save
        @note = Note.new(note_params)
        @notes = @book.notes.order(video_time: "ASC")
        render 'books/edit.js.erb'
      end
  end

  private
  def note_params
    params.require(:note).permit(:text, :video_time).merge(book_id: params[:book_id], user_id: current_user.id)
  end
end
