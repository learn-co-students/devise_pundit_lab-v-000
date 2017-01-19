class NotesController < ApplicationController

  def new
    check_logged_in do
      @note = Note.new(user_id: current_user.id)
      authorize @note
    end
  end

  def create
    check_logged_in do
      if !params[:note][:content].empty?
        note = Note.new(note_params)
        note.user = current_user
        note.save!
        authorize note
        redirect_to '/'
      else
        render :new, alert: 'notes must have content.'
      end
    end
  end

  def edit
    @note = Note.find(params[:id])
    authorize @note
  end

  def update
    @note = Note.find_by(id: params[:id])
    if @note.update_attributes(permitted_attributes(@note))
      redirect_to note_path(@note) unless @note.nil?
    else
      render :edit
    end
  end

  def show
    @note = Note.find_by(id: params[:id])
  end

  def index
    if user_signed_in?
      @notes = Note.none
      if current_user
        @user = current_user
        @notes = @user.readable
      end
    else
      redirect_to pages_about_path
    end
  end

  private

  def note_params
    params.require(:note).permit(:content, :visible_to)
  end

end
