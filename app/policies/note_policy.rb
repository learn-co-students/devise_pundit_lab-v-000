class NotePolicy < ApplicationPolicy
  def create?
    user.admin? || record == user
  end

  def show?
    user.admin? || record == user
  end

  def index?
    user.admin? || record == user
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin? || record == user
  end
end
