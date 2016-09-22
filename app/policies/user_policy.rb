require 'pry'

class UserPolicy < ApplicationPolicy
  attr_reader :user, :the_user
  def initialize(user, the_user)
    @user = user
    @the_user = the_user
  end

  def index?
    user.admin?
  end

  def show?
    the_user == user || user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
