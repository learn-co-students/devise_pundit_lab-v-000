class NotesController < ApplicationController
  before_action :user_logged_in?

  def new
    
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/notes'
  end

  def update
    @note = Note.find_by(id: params[:id])
    @note.update(note_params)
    redirect_to '/notes'    
  end
  
  def edit
    @note = Note.find(params[:id])
    authorize @note
  end
  
  def show
    
  end

  def index
    @notes = current_user.readable
    if current_user.admin? || current_user.moderator?
      @notes = Note.all
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

  def user_logged_in?
    if !current_user
      redirect_to '/'
    end
  end
end
