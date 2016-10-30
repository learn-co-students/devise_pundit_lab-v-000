class NotesController < ApplicationController
  
  def new
    if !current_user
      redirect_to '/'
    end
  end
  
  def create
    if current_user
      note = Note.new(note_params)
      note.user = current_user
      note.save!
    end
    redirect_to '/'
  end

  def update
    @note = Note.find(params[:id])
    authorize(@note)
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    @note = Note.find(params[:id])
    authorize(@note)
  end
  
  def show
    @note = Note.find(params[:id])
    authorize(@note)
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
