class NotesController < ApplicationController
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
  end

  def index
    @notes = Note.none
    @notes = current_user.readable if current_user
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
