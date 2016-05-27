class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

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
    record.try(:id) != user.id
  end
end
