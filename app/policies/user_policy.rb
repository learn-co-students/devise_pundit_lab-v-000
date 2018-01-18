class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @user = user
    @current_user = current_user
  end
  def index?
    @current_user.role == 'admin'
  end
  def show?
     @user == @current_user || @current_user.role == 'admin'
  end
  def update?
    @current_user.role == 'admin'
  end
  def destroy?
    @user!=@current_user
  end
end
