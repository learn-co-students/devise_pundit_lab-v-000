class UserPolicy < ApplicationPolicy

  attr_reader :user, :note

  def initialize(user, note)
    @user = user
    @note = note
  end

  def update?
     user.admin?
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || user.moderator? || note == user
  end

  def destroy?
    user.admin?
  end
  
end
