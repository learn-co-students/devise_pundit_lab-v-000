class NotePolicy < ApplicationPolicy

  def create?
    record.try(:user) == user
  end

  def edit?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end
end
