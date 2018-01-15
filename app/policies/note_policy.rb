class NotePolicy < ApplicationPolicy
  def show?
    user.admin? || user.moderator? || record.try(:user) == user || record.try(:readers).include?(user)
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end
end
