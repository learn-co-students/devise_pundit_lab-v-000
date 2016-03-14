class UserPolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize(user, note)
    super(user, note)
    @note = record  
  end

  def index?
     user.admin?
   end

  def update?
    user.admin? || user.vip? || record.try(:user) == user
  end

  def show?
    user.admin? || record == user
  end

  def destroy?
    user.admin?
  end
end
