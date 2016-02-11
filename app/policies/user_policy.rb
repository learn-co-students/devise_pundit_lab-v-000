class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
     record == user || user.try(:admin?)
  end

  def update?
    record == user || user.try(:admin?)
  end

  def destroy?
    (record != user) && user.try(:admin?)
  end

end