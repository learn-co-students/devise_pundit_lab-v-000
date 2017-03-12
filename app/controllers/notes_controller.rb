class NotesController < ApplicationController

  def new
    @note = current_user.notes.new
    authorize @note
  end

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
    authorize @note
  end

  def show
    @note = Note.find(params[:id])
    authorize @note
  end

  def index
    @notes = Note.none
    authorize @note
    if current_user
      @notes = current_user.readable
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
