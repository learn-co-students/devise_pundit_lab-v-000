class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    record == user || user.admin?
  end

  def update?
  end

  def destroy?
  end

end
