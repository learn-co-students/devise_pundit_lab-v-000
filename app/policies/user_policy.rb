class UserPolicy < ApplicationPolicy

  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @user = record
  end

  def index?
    @current_user.admin? || @current_user = @user
  end

  def show?
    @current_user.admin? || @current_user == @user
  end

  def update?
    @current_user.admin? || @current_user == @user
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin? || @current_user == current_user
  end
end
