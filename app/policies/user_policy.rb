class UserPolicy < ApplicationPolicy

  attr_reader :logged_in_user, :user_accessed

  def initialize(logged_in_user, user_accessed)
    @logged_in_user = logged_in_user
    @user_accessed = user_accessed
  end
  
  def index?
    logged_in_user.admin?
  end

  def show?
    logged_in_user.admin? || logged_in_user == user_accessed
  end

  def update?
    logged_in_user.admin?
  end

  def destroy?
    logged_in_user.admin? && logged_in_user != user_accessed
  end




end
