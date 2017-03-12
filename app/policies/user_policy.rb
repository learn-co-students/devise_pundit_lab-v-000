class UserPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end

  def index?
    false
  end

  def show?
    false
  end

  def edit?
    false
  end

  def destroy?
    false
  end
end
