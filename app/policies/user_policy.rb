class UserPolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize user1, user2
    # binding.pry
    @current_user = user1
    @user = user2
  end

  def show?
    # binding.pry
    @current_user.try(:id) == @user.id
  end
end
