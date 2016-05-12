class NotePolicy < ApplicationPolicy

  def permitted_attributes
    if user.admin? || user.owner_of?(record)
      [:content, :visible_to]
    end
  end

  def create?
    user.admin? || user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end
end