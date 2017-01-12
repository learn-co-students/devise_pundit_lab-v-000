class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    @user.admin?
  end

  def show?
    @user == @model || @user.admin?
  end

  def update?
    @user.admin?
  end

  def destroy?
    if @user == @model
      false
    elsif @user.admin?
      true
    end
  end
  
end
