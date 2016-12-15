class UserPolicy < ApplicationPolicy
  def index?
    self.user.admin?
  end

  def show?
    self.user.admin? || self.user == record
  end

  def update?
    self.user.admin?
  end

  def destroy?
    self.user.admin?
  end

end
