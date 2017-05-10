class NotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.include(:readers).where("reader_id == user_id")
      end
    end
  end

  def initialize(user, note)
    @user = user
    @note = note
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

  def update?
    @user.admin? || @user == @note.user
  end

  def destroy?
    @user.admin? || @user == @note.user
  end
end
