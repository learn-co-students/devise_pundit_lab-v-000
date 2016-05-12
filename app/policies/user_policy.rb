class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || record.try(:id) == user.id
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
