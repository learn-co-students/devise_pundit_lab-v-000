class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_note, except: [:index, :new, :create]

  def new
    @note = Note.new
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

  def find_note
    @note = Note.find_by(params[:id])
  end

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end
end
