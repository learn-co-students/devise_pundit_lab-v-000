require 'pry'

class UserPolicy < ApplicationPolicy
  attr_reader :user, :role
  def initialize(user, role)
    @user = user
    @role = role
  binding.pry
  end

  def index?
    user.admin?
  end

end
