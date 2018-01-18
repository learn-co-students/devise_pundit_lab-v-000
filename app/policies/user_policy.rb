class UserPolicy < ApplicationPolicy

  def index?
    user.admin? 
  end

  def show?
    user.admin? || (user == record) #record is an instance of a user and user is the current user?
  end

  def update?
    user.admin? || (user == record) 
  end

  def destroy?
    user.admin? && (user != record)
  end




end
