class NotesController < ApplicationController

  include Pundit

  def new

  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    @note.destroy
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
    @note = Note.find(params[:id])
    authorize @note
  end

  def index
    if current_user
      @notes = policy_scope(Note.all)
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
