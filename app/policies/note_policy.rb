class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        user.readable
      end
    end
  end

  def initialize(user, note)
    @user = user
    @note = note
  end

  def new?
    true
  end

  def create?
    @note.user == @user
  end

  def add_reader?
    @user.admin? || @user == @note.user
  end

  def remove_reader?
    @user.admin? || @user == @note.user
  end

  def show?
    return true if @user.admin? || @user.moderator? || @user == @note.user
    if @note.readers
      @note.readers.any? {|user| @user.id == user.id }
    end
  end

  def edit?
    @user.admin? || @user == @note.user
  end

  def update?
    @user.admin? || @user == @note.user
  end

  def destroy?
    @user.admin? || @user == @note.user
  end
end
