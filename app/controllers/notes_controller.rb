class NotesController < ApplicationController

  def new

  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    @note.save!
    redirect_to note_path(@note)
  end

  def update
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
    @note = Note.find(params[:id])
    @user = current_user
    authorize @user
  end

  def index
    @notes = Note.all
    authorize current_user
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
