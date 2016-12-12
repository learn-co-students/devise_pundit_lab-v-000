class UserPolicy < ApplicationPolicy
 attr_reader :user, :note


  def initialize(user, note)
    @user = user
    @note = note
  end

  def index?

  end

  def show?
  end
  
  def update?
    user.admin?  || note.try(:user) == user
  end

  def destroy?
  end
end
