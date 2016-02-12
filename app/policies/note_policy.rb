class NotePolicy < ApplicationPolicy
  def create?
    record == user || user.admin?
  end

  def update?
    record == user || user.admin?
  end
end
