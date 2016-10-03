class NotesController < ApplicationController

  before_action :set_note!, only: [:show, :edit, :update, :destroy]

  # NOTE: This pundit method will raise an exception if authorize is not called in controller.
  # Place in ApplicationController if all controllers should inhert rule.
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index


  def index
    user = User.find(params[:user_id])
    @notes = policy_scope(user.notes)
    authorize user
    
    # user = User.find(params[:user_id])
    # @notes = policy_scope(Note)
    # authorize(user)
  end

  def new
    user = User.find(params[:user_id])
    @note = user.notes.build
    authorize @note
  end

  def create
    user = User.find(params[:user_id])
    @note = user.notes.build(note_params)
    authorize @note
    if @note.save
      redirect_to user_note_path(user, @note), notice: 'Your note was successfully created.'
    else
      render :new
    end
  end


  def show
    # @note = user.notes.find(params[:id])
    authorize @note
  end

  def edit
    authorize @note
  end

  def update
    authorize @note
    @note.update(note_params)
    if @note.save
      redirect_to user_note_path(@note.user, @note), notice: 'Your note was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @note
    @note.destroy
    redirect_to user_notes_path(@note.user) , notice: 'Your note was successfully deleted.'
  end

  private
    def set_note!
      @note = Note.find_by(id: params[:id])
    end

    def note_params
      params.require(:note).permit(:content, :visible_to, :user_id)
    end
end
