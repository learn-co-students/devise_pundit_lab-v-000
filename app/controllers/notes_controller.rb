class NotesController < ApplicationController
  
  def new
    # authorize @notes
  end
  
  def create
    @note = Note.new(note_params)
    @note.user = current_user
    @note.save!
    authorize @note
  end

  def update
    @note = Note.find(params[:id])
    authorize @note
    @note.update(note_params)
    flash[:notice] = "Your note was updated."
    redirect_to '/'    
  end
  
  def edit
    # binding.pry
    @note = Note.find(params[:id])
    if !policy(@note).edit?
      redirect_to '/'
    end
  end
  
  def show
    authorize @note
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
  
  # def authorize_note
  #   authorize current_user
  # end
  
end
