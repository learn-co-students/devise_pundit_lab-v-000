class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :u

  def initialize(current_user, u)
    @current_user = current_user
    @user = u
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user == @user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end

end