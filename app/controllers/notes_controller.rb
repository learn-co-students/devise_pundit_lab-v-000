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
    authorize @note
  end
  
  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to note_path(note)
  end

  def update
    @note.update(note_params)
    authorize @note
    redirect_to note_path(@note)    
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
    redirect_to root_path
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
