class NotesController < ApplicationController

  def new

  end

  def create
    note = Note.new(note_params)
    authorize note
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    authorize @note
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
    authorize @note
  end

  def show
    authorize @note
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    @note.destroy
    redirect_to notes_path
  end


  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
