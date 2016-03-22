class NotePolicy < ApplicationPolicy
  def initialize(current_user, note)
    @current_user = current_user
    @note = note
  end

  def create?
    @current_user.admin? || @current_user.id == @note.user.id
  end

  def index?
    @current_user.admin? || @current_user.vip?
  end

  def show?
    @current_user.admin? || @current_user.id == @other_user
  end

  def update?
    @current_user.admin? || @current_user.id == @note.user.id
  end

  def destroy?
    @current_user.admin? || @current_user.id == @note.user.id
  end

end
