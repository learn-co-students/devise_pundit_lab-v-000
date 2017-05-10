class NotePolicy < ApplicationPolicy

  def initialize(user, note)
    @user = user
    @note = note
  end

  def show?
     @user.admin? || @user.moderator? || @user.id == @note.user.id
  end

  def update?
    @user.admin?
  end

  def destroy?
    return true if(@user == @note.user)
    @user.admin?
  end
end
