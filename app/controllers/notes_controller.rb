class NotesController < ApplicationController

  before_action :find_and_authorize_note, only: [:update, :edit, :show, :destroy]

  def new
    # raise current_user.inspect
    @note = Note.new
    authorize @note
  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to note_path(note)
  end

  def update
    @note.update(note_params)
    redirect_to note_path(@note)
  end

  def edit
  end

  def show
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  def destroy
    @note.delete
    flash[:message] = "Note #{@note.id} has been deleted."
    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

  def find_and_authorize_note
    @note = Note.find(params[:id])
    authorize @note
  end
end
