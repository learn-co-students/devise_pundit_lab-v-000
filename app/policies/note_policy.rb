class NotePolicy < ApplicationPolicy

  def create?
    user.admin? 
  end

  def show?
    user.admin? || record == user || user.moderator? || user.reader?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
