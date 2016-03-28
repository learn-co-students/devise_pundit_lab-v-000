class NotePolicy < ApplicationPolicy

  def permitted_attributes
    if user.admin? || user.owner_of(note)
      [:content, :visible_to]
    end
  end

  def index?
    user.admin? || note.try(:readers).include?(user)
  end

  def show?
    user.admin? || note.try(:readers).include?(user)
  end

  def update?
    user.admin? || user.owner_of?(note)
  end

  def destroy?
    user.admin? || user.owner_of?(note)
  end

end