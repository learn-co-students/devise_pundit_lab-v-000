class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin? || user.moderator?
  end

  def show?
    user.admin? || user.moderator? || record.try(:id) == user.id
  end

  def update?
    record.try(:id) == user.id || user.admin?
  end

  def destroy?
    user.admin?
  end
end
