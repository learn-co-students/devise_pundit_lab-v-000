class NotesController < ApplicationController

  def new

  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    @note = Note.find(params[:id])
    authorize @note
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
    if current_user
      if current_user.admin? || current_user.moderator?
        @notes = Note.all
      else
        @notes = current_user.readable
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    @note.delete
    redirect_to '/'
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
