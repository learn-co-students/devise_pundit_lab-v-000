class NotesController < ApplicationController

  # skip_after_action :verify_authorized
  # skip_after_action :verify_policy_scoped
  
  def new
    authorize Note.new
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    authorize note
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
    if current_user
      @notes = current_user.readable
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
