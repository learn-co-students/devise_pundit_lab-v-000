class UserPolicy < ApplicationPolicy

  attr_reader :user

  def initialize(current_user, target_user)
    @current_user = current_user
    @target_user = target_user
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? || @current_user == @target_user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin? && (@current_user != @target_user)
  end

end
