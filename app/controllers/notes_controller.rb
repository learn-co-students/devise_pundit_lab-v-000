class NotesController < ApplicationController
  
  def new
    
  end
  
  def create
    @note = Note.new(note_params)
    if @note.valid?
      @note.user = current_user
      @note.save!
      redirect_to note_path(@note)
    else
       redirect_to new_note_path, notice: "Error. Note can't be blank."
    end
  end

  def update
    @note = Note.find(params[:id])   
    authorize @note
    @note.update(note_params)
    redirect_to note_path(@note)  
      #   redirect_to note_path(@note)  
      # if @note.valid?
      #   @note.update(note_params)
      #   redirect_to note_path(@note)  
      # else
      #   redirect_to notes_path, message: "Access denied."
      # end
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def show
    @note = Note.find(params[:id])
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
