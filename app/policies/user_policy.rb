class UserPolicy < ApplicationPolicy

  # only an admin can view the index
  def index?
    user.admin?
  end

  # only yourself and an admin can see your profile
  def show?
    user.admin? || record == user
  end

  # only an admin can update posts
  def update?
    user.admin?
  end

  # only an admin can delete users, but an admin cannot delete themselves
  def destroy?
    user.admin? && record.try(:user) != user
  end

end
