class NotesController < ApplicationController
  after_action :verify_authorized, except: [:index]

  def new
    
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    authorize note

    note.save!
    redirect_to '/'
  end

  def update
    @note = Note.find(params[:id])
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def show
    @note = Note.find(params[:id])
    authorize @note
  end

  def index
    @notes = Note.none
    if current_user
      @notes = current_user.readable
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if authorize @note
      @note.delete
      redirect_to "/"
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
