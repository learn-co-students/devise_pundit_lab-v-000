class NotesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_current, except: [:index]
  before_action :set_note, except: [:index, :new]


  def index
    redirect_to user_path(current_user) if current_user.user? 
    @notes=Note.all
  end

  def new
    @note=Note.new
  end
  
  def create

    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to note_path(note)
  end

  def update
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    @note = Note.find(params[:id])
  end
  
  def show
    @note= Note.find_by(id: params[:id])
  end


  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

  def set_note
    @note=Note.find_by(id: params[:id])
  end

  def set_current
    @current_user=current_user
  end



end
