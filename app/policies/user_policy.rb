class UserPolicy < ApplicationPolicy
  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user == @note
  end

  def update?
    @current_user.admin? || @current_user == @note
  end

  def destroy?
    @current_user.admin?
  end
end
