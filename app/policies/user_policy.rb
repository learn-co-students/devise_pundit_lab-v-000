class UserPolicy < ApplicationPolicy
  def update?
    user.admin?
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || record == user
  end

  def destroy?
    user.admin?
  end
end
