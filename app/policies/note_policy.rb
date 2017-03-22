class UserPolicy < ApplicationPolicy
  attr_reader :note

  def initialize(user, note)
    super(user, note)
    @note = record
  end

  def create?
    note.try(:user) == user
  end

  def show?
    user.admin? || user.moderator? || user.reader_of?(note)
  end

  def update?
    user.admin? || user.moderator? || note.try(:user) == user
  end

  def destroy?
    user.admin? || note.try(:user) == user
  end

end
