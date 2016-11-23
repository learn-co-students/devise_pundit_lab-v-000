class NotesController < ApplicationController
  before_filter :authenticate_user!

  skip_before_filter :authenticate_user!, only: [:index]

  def new

  end

  def create
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def edit
    @note = Note.find(params[:id])
    authorize @note
  end

  def update
    @note = Note.find(params[:id])
    authorize @note
    @note.update(note_params)
    redirect_to '/'
  end

  def show
  end

  def index
    @notes = Note.none
    if current_user
      if current_user.admin? || current_user.vip?
        @notes = Note.all
      else
        @notes = current_user.readable
      end
    end
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note
    @note.destroy
    redirect_to '/'
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
