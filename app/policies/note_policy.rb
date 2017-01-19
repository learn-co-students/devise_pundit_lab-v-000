class NotePolicy < ApplicationPolicy
  def update?
    record.user_id == user.id || user.admin?
  end

  def permitted_attributes
    if user.admin? || record.user_id == user.id
      [:content, :visible_to]
    end
  end
end
