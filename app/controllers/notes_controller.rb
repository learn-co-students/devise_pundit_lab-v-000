class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  
   def index
    @notes = policy_scope(Note)  
  end

  def new
  
  end
  
  def create
    @note = Note.new(note_params)
    @note.user = current_user
    @note.save!
    authorize @note
    
    redirect_to @note
  end

  def update
    authorize @note
    @note.update(note_params)

    redirect_to '/'    
  end
  
  def edit
    authorize @note
  end
  
  def show
    authorize @note
  end

  def destroy
    authorize @note
    @note.destroy
    redirect_to note_path, alert: "Note successfully destroyed"
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
