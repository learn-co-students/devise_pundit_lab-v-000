class UserPolicy < ApplicationPolicy

  def show?
    user.admin? || record == user
  end

  def index?
    user.admin?
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? && record != user
  end
end
