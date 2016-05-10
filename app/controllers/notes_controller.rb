
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
    @note.update_attributes(permitted_attributes(@note))
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
  end

  def show
  end

  def index
    @notes = Note.all
    # binding.pry
    @user = current_user
    if current_user
      @notes = current_user.readable
      #authorize @notes
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
