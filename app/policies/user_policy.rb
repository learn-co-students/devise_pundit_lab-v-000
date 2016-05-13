class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.vip?
  end


  def show?
    user.admin? || user.vip? || user == @record
  end


  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end



end