class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || record == user
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def permitted_attributes
    if user.admin? || record == user
         [:name, :email, :password]
    end
  end

end
