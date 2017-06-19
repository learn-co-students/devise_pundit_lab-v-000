class UserPolicy < ApplicationPolicy

  def index?
    # check if the user attempting to get to this page is an admin
    user.admin?
  end

  def show?
    # if the record is the same as the user (it is your account)
    # or if the user is an admin (can see all the accounts)
    record == user || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? && record != user
  end
end
