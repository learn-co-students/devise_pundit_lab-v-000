class NotePolicy < ApplicationPolicy

  def new?
    user.admin? || user.moderator? || user.normal?
  end

  def create?
    user.admin? || record.user_id == user.id
  end

  def edit?
    record.user_id == user.id || user.admin?
  end

  def permitted_attributes
    if user.admin? || record.user_id == user.id
      [:content, :visible_to]
    end
  end
end
