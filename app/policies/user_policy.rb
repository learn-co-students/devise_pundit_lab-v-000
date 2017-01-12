class UserPolicy < ApplicationPolicy

  def create?
    user.admin? || record.try(:user) == user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end

  def show?
    user.admin? || record == user
  end

  def index?
    user.admin?
  end
  # add_viewers?

  # remove_viewers?

  # see notes they are viewers of

  # see their own notes

  # moderators can view all notes
end
