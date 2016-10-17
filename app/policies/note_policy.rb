class NotePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
   @user = user
   @record = record
  end

  def create?
    user.admin? || record.try(:user_id) == user.id
  end

  def index?
    user.admin? || user.moderator?
  end

  def edit?
    user.admin? || record.try(:user_id) == user.id
  end

  def show?
    user.admin? || user.moderator? || record.try(:user_id) == user.id
  end

  def update?
    user.admin? || record.try(:user_id) == user.id
  end

  def destroy?
    user.admin? || record.try(:user_id) == user.id
  end

end
