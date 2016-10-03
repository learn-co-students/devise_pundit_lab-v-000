class NotesController < ApplicationController

  def new

  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    @note.update(note_params)
    authorize @note
    redirect_to '/'

    # if @note.update_attributes(permitted_attributes(@note))
    #     redirect_to @note
    # else
    #   render :edit
    # end
  end

  def edit
    @note = Note.find(params[:id])
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
end
