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
     @user.admin? || @user.moderator? || @user.id == @note.user.id
  end

  def update?
    @user.admin? || @user == @note.user
  end

  def destroy?
    @user.admin? || @user == @note.user
  end
end
