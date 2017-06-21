class UserPolicy < ApplicationPolicy
  attr_reader :user, :user2

  def initialize(user, user2)
    @user = user
    @user2 = user2
  end

  def index?
    user.admin?
  end

  def create?
    true
  end

  def show?
    user == user2 || user.admin?
  end

  def edit?
    update?
  end

  def update?
    user == user2 || user.admin?
  end

  def destroy?
    user.admin? && user != user2
  end

  class Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user2.id)
      end
    end
  end
end
