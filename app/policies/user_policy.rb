class UserPolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize user1, user2
    @current_user = user1
    @user = user2
  end

  def show?
    @current_user.admin? || @current_user.try(:id) == @user.id
  end

  def index?
    @current_user.admin?
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user.admin?
  end
end
