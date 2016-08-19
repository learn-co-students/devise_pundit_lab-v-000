class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || record.try(:id) == user.id
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? && (record != user)
  end

end