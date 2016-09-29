class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def show?
    user.admin? || record == user
  end

  def update?
    user.admin? # put this in a before_action
  end
end
