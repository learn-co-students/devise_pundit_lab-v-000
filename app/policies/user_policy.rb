class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? ||
  end

  def update?
    user.admin? || record.try(:user) == user

   end

end
