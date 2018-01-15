class NotesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def new
    authorize Note
  end

  def create
    authorize Note
    note = Note.new(note_params)
    note.user = current_user
    note.save!
    redirect_to '/'
  end

  def update
    authorize @note
    @note.update(note_params)
    redirect_to '/'
  end

  def edit
    authorize @note
  end

  def show
    authorize @note
  end

  def index
    @notes = policy_scope(Note)
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
