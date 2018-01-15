class UserPolicy < ApplicationPolicy


  def show?
    record == user || user.admin?
  end

  def index?
    #denies access if not an admin
    #allows access for an admin
    user.admin?
  end

  def update?
  #prevents updates if not an admin
  #allows an admin to make updates
   user.admin?
  end

  def destroy?
    #prevents deleting yourself
    #allows an admin to delete any user
    user.admin? || user != record
  end


end
