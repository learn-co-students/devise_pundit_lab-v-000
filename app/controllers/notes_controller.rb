class NotesController < ApplicationController
  
  def new
    # authorize @notes
  end
  
  def create
    # authorize @notes
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    # authorize @notes
  end

  def update
    # authorize @notes
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    @note = Note.find(params[:id])
    # authorize @notes
  end
  
  def show
    # authorize @notes
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
    # authorize @notes
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
  
  # def authorize_note
  #   authorize current_user
  # end
  
end
