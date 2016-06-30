class UserPolicy < ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end
  def index?
    user.admin?
  end

  def show?
    user.admin? || record.user == user
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
