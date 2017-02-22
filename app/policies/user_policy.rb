class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.moderator?
  end

  def show?
    user.admin? || user.moderator? || record == user
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
