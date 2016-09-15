class NotePolicy < ApplicationPolicy

    def initialize(user, note)
      @user = user
      @note = note
    end

    def create?
      @user.admin? || @user.id == @note.user_id
    end

    def update?
      @user.admin? || @user.id == @note.user_id
    end

    def destroy?
      @user.admin? || @user.id == @note.user_id
    end

    def add_viewers?
      @user.admin? || @user.id == @note.user_id
    end

    def remove_viewers?
      @user.admin? || @user.id == @note.user_id
    end

    def viewer_of?
      @user.admin? || @user.id == @note.user_id
    end

    def show?
      @user.admin? || @user.id == @note.user_id
    end

    def index?
      @user.admin? || @user.mod?
    end
end
