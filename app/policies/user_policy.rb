class UserPolicy < ApplicationPolicy

  attr_reader :user, :record

  def initialize(user, record)
        @user = user
        @record = record
  end



  def index?
    user.admin?
  end



  def update?
    user.admin?
  end

  def destroy?
    user.admin? && user != record
  end

  def show?
    user.admin? || user == record 
  end


end
