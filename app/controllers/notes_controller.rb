class NotesController < ApplicationController

  before_action :find_note, only: [:update, :edit, :show]

  def new
    @note = Note.new
    authorize @note, :create
  end

  def create
    # note = Note.new(note_params)
    # note.user = current_user
    # note.save!
    # redirect_to '/'
    note = current_user.notes.build(note_params)
    authorize note
    redirect_to root_path
  end

  def update
    # @note.update(note_params)
    # redirect_to '/'
    authorize @note
    @note.update(note_params)
    redirect_to root_path
  end

  def edit
    authorize @note, :update
  end

  def show
    authorize @note
  end

  def index
    # @notes = Note.none
    # if current_user
    #   @notes = current_user.readable
    # end
    @notes = policy_scope(Note)
  end

  private

    def note_params
      params.require(:note).permit(:content, :visible_to)
    end

    def find_note
      @note = Note.find(params[:id])
    end
end
