class NotePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user.moderator? || record.readers.include?(user)
  end

  def update?
    user.admin? || record.readers.include?(user)
  end

  def destroy?
    user.admin? || record.readers.include?(user)
  end
end
