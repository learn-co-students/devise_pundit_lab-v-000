class NotePolicy < ApplicationPolicy

  def show?
    user.moderator? || user.admin? || record.try(:user) == user
  end

  def create?
    user.admin? || record.try(:user) == user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
     user.admin? || record.try(:user) == user
  end

end
