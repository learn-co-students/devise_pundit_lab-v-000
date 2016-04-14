class NotesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
  before_action :set_note, except: [:index, :new]


  def index
    @notes=Note.all
    redirect_to user_path(current_user) if NotesPolicy.new(current_user, @notes).index?
  end

  def new
    @note=Note.new
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
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

  def set_note
    @note=Note.find_by(id: params[:id])
  end
end
