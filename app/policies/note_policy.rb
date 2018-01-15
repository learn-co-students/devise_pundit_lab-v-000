class NotePolicy < ApplicationPolicy

  def show?
    user.admin? || record.try(:reader) == user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end
end
