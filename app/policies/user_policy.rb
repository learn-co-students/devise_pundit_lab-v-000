class UserPolicy < ApplicationPolicy 

  def show?
    user.admin? || record.id == user.id
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end 

  def destroy?
    user.admin?
  end

end