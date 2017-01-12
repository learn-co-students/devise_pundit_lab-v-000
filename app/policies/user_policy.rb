class UserPolicy < ApplicationPolicy
  def show?
    record == user || user.admin?
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    record != user && user.admin?
  end
end
