class UserPolicy < ApplicationPolicy
  attr_reader :current_use, :user_check

  def initialize(current_use, user_check)
    @current_use = current_use
    @user_check = user_check
  end

  def index?
    current_use.admin?
  end

  def show?
    current_use.admin? || current_use == user_check
  end

  def update?
    current_use.admin?
  end

  def destroy?
    current_use.admin? unless current_use == user_check
  end
end
