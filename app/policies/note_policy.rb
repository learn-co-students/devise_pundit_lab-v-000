class NotePolicy < ApplicationPolicy

  # def permitted_attributes
  #   if user.admin? || user.owner_of?(record)
  #     [:content, :visible_to]
  #   end
  # end

  def create?
    user.admin? || user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end

  def index?
    user.admin? || user.moderator? || user
  end

  def show?
    user.admin? || user.moderator? || record.try(:user) == user || record.try(:visible_to).include?(user.name)
  end
end