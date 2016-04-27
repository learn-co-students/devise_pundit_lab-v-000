class UserPolicy < ApplicationPolicy
  attr_reader :user

  def show?
    user.admin? || record == user
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? && (record != user)
  end


end
