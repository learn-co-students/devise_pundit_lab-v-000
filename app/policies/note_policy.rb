class NotePolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize(user, record)
    @user = user
    @note = record
  end

  def create?
    user.user?
  end

  def index?
    user.admin? || user.moderator?
  end

  def show?
    user.admin? || user.moderator? || note.try(:user) == user
  end

  def destroy?
    user.admin? || note.try(:user) == user
  end

  def update?
    user.admin? || note.try(:user) == user
  end
end