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
      flash[:notice] = "Created note."
    end
    redirect_to '/'
  end

  def update
    @note = Note.find(params[:id])
    authorize(@note)
    @note.update(note_params)
    flash[:notice] = "Edited note."
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
    if current_user.try(:role) == 'admin' || current_user.try(:role) == 'moderator'
      @notes = Note.all
    elsif current_user
      @notes = current_user.readable
    else
      @notes = Note.none
    end
    authorize(@notes)
  end

  def destroy
    @note = Note.find(params[:id])
    authorize(@note)
    @note.destroy
    flash[:notice] = "Note deleted."
    redirect_to '/'
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
