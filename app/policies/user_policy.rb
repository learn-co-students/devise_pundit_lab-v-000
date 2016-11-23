class UserPolicy < ApplicationPolicy
  def index?
    user.try(:admin?)
  end

  def show?
    user.try(:admin?) || record == user
  end

  def update?
    user.try(:admin?) || record == user
  end

  def destroy?
    user.try(:admin?)
  end

  def  permitted_attributes
    if user.try(:admin?) || record == user
      [:email, :password]
    end
  end
end
