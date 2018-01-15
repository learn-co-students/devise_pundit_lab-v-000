class UserPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def index?
    user.admin?
  end

  def show?
    user == record || user.admin?
  end
  
  def update?
    user.admin?
  end

  def destroy?
    (user.admin?) && (user != record)
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
