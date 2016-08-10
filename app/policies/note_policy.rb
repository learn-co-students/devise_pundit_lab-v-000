class NotePolicy < ApplicationPolicy

  def show?
    user.admin? || user.moderator? || user == record
  end

  def create?
    user.admin? || user == record
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin? || user == record
  end
end
