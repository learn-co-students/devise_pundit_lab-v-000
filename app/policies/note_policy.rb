class NotePolicy < ApplicationPolicy

  def initialize(user, note)
    @user = user
    @note = note
  end

  def create?
    @note.user == @user
  end

  def add_viewer?
    @user.admin? || @user == @note.user
  end

  def remove_viewer?
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
