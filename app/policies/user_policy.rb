class UserPolicy < ApplicationPolicy

  attr_reader :user, :user2

  def initialize(user, user2)
    @user = user
    @user2 = user2
    
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == user2
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end



end
