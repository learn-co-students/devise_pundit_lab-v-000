class UserPolicy < ApplicationPolicy
  def show?
    user.admin? || user.moderator? || record == user
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
