class UserPolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize(user, note)
    @user = user
    @note = note
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || record.try(:user) == user
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
