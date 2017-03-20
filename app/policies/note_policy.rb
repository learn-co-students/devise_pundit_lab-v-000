class UserPolicy < ApplicationPolicy
  attr_reader :note

  def initialize(user, note)
    super(user, note)
    @note = record
  end

  def update?
    user.admin? || user.moderator? || note.try(:user) == user
  end

end
