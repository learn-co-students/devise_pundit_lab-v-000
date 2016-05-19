class UserPolicy < ApplicationPolicy

  def show?
    # binding.pry
    user.admin? || user.vip? || record == user
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
