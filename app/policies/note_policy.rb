class NotePolicy < ApplicationPolicy
  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user.moderator? || @current_user == @note
  end

  def create?
    @current_user.admin? || @current_user == @note
  end

  def update?
    @current_user.admin? || @current_user == @note
  end

  def destroy?
    @current_user.admin?
  end

  def permitted_attributes
    if @current_user.admin? || @current_user == @note
      [:content, :visible_to]
    end
  end
end