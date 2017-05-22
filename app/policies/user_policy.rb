class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user == record || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user != record
  end
end
