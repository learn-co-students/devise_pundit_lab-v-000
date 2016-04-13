class UserPolicy < ApplicationPolicy


  def index?
    user.admin?
  end

  def show?
    user.admin? || record == current_user

  end


  def update?

  end

  def destroy?

  end

end
