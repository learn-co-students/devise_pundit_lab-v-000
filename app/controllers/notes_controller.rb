class NotesController < ApplicationController
    before_filter :authenticate_user!
    def new

    end

    def create
        note = Note.new(note_params)
        note.user = current_user
        note.save!
        redirect_to notes_path
    end

    def update
        @note = Note.find(params[:id])
        @note.update(note_params)
        redirect_to notes_path
    end

    def edit
        @note = Note.find(params[:id])
        authorize @note
    end

    def show
        @note = Note.find(params[:id])
        authorize @note
    end

    def index
        @notes = Note.none

        if current_user
            @notes = current_user.readable
        end
    end

    def destroy
        @note = Note.find(params[:id])
        authorize @note
        @note.destroy
        redirect_to notes_path
    end
    private

    def note_params
        params.require(:note).permit(:content, :visible_to)
    end
end
