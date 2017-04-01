class UserPolicy < ApplicationPolicy
  def show?
    user.admin? || user == current_user
  end
end
