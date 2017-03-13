class UserPolicy < ApplicationPolicy

  # user can see profile page (UsersController#show action) only if owns the page or if admin
  def show?
    record == user || user.admin?
  end

  # allows access to UsersController#index action to an admin
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