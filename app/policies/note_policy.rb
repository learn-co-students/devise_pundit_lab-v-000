class NotePolicy < ApplicationPolicy
  def create?
    user.admin? || user.id == record.user_id
  end

  def edit?
    user.admin? || user.id == record.user_id
  end

  def delete?
    user.admin? || user.id == record.user_id
  end

  def show?
    return true if user.admin?
    return true if user.id == record.user_id
    return true if record.visible_to.include?(user.email)
  end
end
