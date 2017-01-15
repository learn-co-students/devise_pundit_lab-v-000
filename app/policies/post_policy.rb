class PostPolicy < ApplicationPolicy

  def create?
    record == user || user.admin?
  end

  def update?
    record == user || user.admin?
  end

  def destroy?
    record == user || user.admin?
  end

end
