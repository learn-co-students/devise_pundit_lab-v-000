class NotesController < ApplicationController
  before_action :set_user

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
  end

  def update
    @note = Note.find_by(id: params[:id])
    if @note.update_attributes(permitted_attributes(@note))
      redirect_to @note
    else
      render :edit
    end
  end

  def show
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

  def set_user
    @user ||= User.find_by(id: params[:id])
  end
end
