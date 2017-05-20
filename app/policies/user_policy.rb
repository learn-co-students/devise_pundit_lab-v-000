class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def update?
    user.admin?
  end

  def destroy?
    user !=record && user.admin?
  end

end
