class UserPolicy < ApplicationPolicy

  def initialize(current, other)
    @current = current
    @other = other
  end

  def index?
    @current.admin?
  end

  def show?
    @current == @other || @current.admin?
  end

  def update?
    @current.admin?
  end

  def destroy?
    return false if(@current == @other)
    @current.admin?
  end
end
