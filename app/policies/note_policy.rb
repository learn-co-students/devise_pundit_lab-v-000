class NotePolicy < ApplicationPolicy

    attr_reader :current_user, :model

    def initialize(current_user, model)
        @current_user = current_user
        @note = model
    end

    def index?
      @current_user.admin? || @current_user.vip? || @current_user.user?
    end

    def show?
        @current_user.admin? || @current_user.vip? || @note.readers.include?(@current_user)
    end

    def edit?
      @current_user.admin? || @note.readers.include?(@current_user)
    end

    def update?
        @current_user.admin? || @note.readers.include?(@current_user)
    end

    def destroy?
        @current_user.admin? || @note.readers.include?(@current_user)
    end
end
