class UserPolicy < ApplicationPolicy
  # class Scope < Scope
  #   def resolve
  #     if record == user
  #       scope.where(published: true)
  #     # if user.admin?
  #     #   scope.all
  #     else
  #       scope.where(published: true)
  #     end
  #   end
  # end

  def index?
    # binding.pry
    record == user || user.admin?
  end

  def show?
    # binding.pry
    record == user || user.admin?
    # user.admin? || record.try(:user) == user
  end

  def edit?
    # binding.pry
    user.admin? || record.try(:user) == user
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end
end
