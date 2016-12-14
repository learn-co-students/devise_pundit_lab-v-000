class NotePolicy < ApplicationPolicy

  def create?
    record.try(:user) == user || user.admin?
  end

  def update?
    record.try(:user) == user || user.admin?
  end

  def show?
    record.try(:user) == user || record.try(:viewers).include?(user) || user.admin?
  end

  def destroy?
    record.try(:user) == user || user.admin?
  end

end
