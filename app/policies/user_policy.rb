class UserPolicy < ApplicationPolicy
  attr_reader :user, :other_user

  def initialize(user, other_user)
    @user = user
    @other_user = other_user
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? or user == @other_user
  end

  def update?
    user.admin? or user == @other_user
  end

  def destroy?
    user.admin? 
  end

end
