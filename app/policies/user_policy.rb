class UserPolicy < ApplicationPolicy

  # denies access if not an admin
  # allows access for an admin
  def index?
    user.admin?
  end

  # prevents other users from seeing your profile
  #  allows you to see your own profile
  #  allows an admin to see any profile
  def show?
    user.admin? || user == record
  end

  # prevents updates if not an admin
  # allows an admin to make updates
  def update?
    user.admin? || user == record
  end

  # prevents deleting yourself
  # allows an admin to delete any user
  def destroy?
    user.admin?
  end
end
