class UserPolicy < ApplicationPolicy
  attr_reader :user, :record
  
  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def index?
    @user.admin?
  end
  
  def show?
    @user.admin? || @user == @record
  end
  
  def update?
    @user.admin? || @user == @record
  end
  
  def destroy?
    @user.admin?
  end
end
