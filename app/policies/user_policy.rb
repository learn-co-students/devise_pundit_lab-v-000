class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == current_user
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? && user != current_user
  end

end
