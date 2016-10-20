class NotePolicy < ApplicationPolicy

  def create?
    user.admin? || record.try(:user_id) == user.id
  end

  def update?
    user.admin? || record.try(:id) == user.id
  end

  def destroy?
    user.admin? || record.try(:id) == user.id
  end

  def show?
    user.admin? || user.moderator? || record.try(:id) == user.id
  end
end
