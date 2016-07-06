class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_note, only: [:show, :edit, :update, :destroy]
  
  rescue_from Pundit::NotAuthorizedError, with: :redirect_to_notes_path
  
    def new
      
    end
    
    def create
      note = Note.new(note_params)
      note.user = current_user
      note.save!
      redirect_to notes_path
    end
  
    def update
      @note.update(note_params)
      redirect_to notes_path    
    end
    
    def edit
      # @note = Note.find(params[:id])
    end
    
    def show
      # @note = Note.find(params[:id])
    end
  
    def index
      @notes = Note.none
      if current_user
        @notes = current_user.readable
      end
    end
    
    def destroy 
      @note.destroy
      redirect_to notes_path
    end

  private
  
    def note_params
      params.require(:note).permit(:content, :visible_to)
    end
    
    def authorize_note 
      @note = Note.find(params[:id])
      authorize @note
    end
    
    def redirect_to_notes_path 
      flash[:alert] = "You don't have permission to do that"
      redirect_to notes_path
    end
  
end
