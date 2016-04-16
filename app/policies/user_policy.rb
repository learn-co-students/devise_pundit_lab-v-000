class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def show?
    current_user.admin? || record == user
  end

  def index?
    current_user.admin?
  end

  def update?
    user.admin? || record == user
  end

  def destroy?
    user.admin?
  end

end
