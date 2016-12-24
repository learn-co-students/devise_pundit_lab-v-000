class UserPolicy < ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin? && user != record
  end

  def permitted_attributes
    if user.admin? || user == record
      [:email]
    end
  end


  class Scope

    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

end
