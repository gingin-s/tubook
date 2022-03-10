class NotesController < ApplicationController
  def index

  end

  def create
    @book = Book.find(params[:book_id])
    @note = Note.new(note_params)
      if @note.save
        @notes = @book.notes.order(seek_time: "ASC")
        gon.watch.notes = @notes
        redirect_to edit_book_path(params[:book_id])
        # render 'books/edit.js.erb'
      else
        render template: "books/edit"
      end
  end

  private
  def note_params
    params.require(:note).permit(:text, :video_time).merge(book_id: params[:book_id], user_id: current_user.id)
  end
end
