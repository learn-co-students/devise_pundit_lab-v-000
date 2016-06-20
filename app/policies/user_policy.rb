class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:user => user)
      end
    end
  end
  
  def index?
    user.admin?
  end

  def show?
    user.admin? || record.try(:id) == user.id
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
