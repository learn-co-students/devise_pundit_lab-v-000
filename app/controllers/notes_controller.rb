class NotesController < ApplicationController
  before_action :set_note, only: [:edit, :update, :show]
  before_action :authenticate_user!, except: :index
  
  def new
    
  end
  
  def create
    @note = current_user.notes.build(note_params)
    if @note.save
      redirect_to root_path
    else
      render :new, alert: "Content can't be blank"
    end
  end

  def update
    @note.update(note_params)
    redirect_to '/'    
  end
  
  def edit
    if !current_user.admin? && current_user != @note.user
      redirect_to notes_path
    end
  end
  
  def show
    if !current_user.admin? && current_user != @note.user
      redirect_to :back, alert: "Access denied."
    end
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
    @note = Note.find(params[:id])
  end
end
