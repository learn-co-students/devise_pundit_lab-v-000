class UserPolicy < ApplicationPolicy

  attr_accessor :user, :record

  def initialize(user,record)
    @user=user
    @record=record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || record == user
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? && record != user
  end
end
