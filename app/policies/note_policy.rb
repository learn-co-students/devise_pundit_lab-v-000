class NotePolicy < ApplicationPolicy

  attr_reader :logged_in_user, :record

  def initialize(logged_in_user, record)
    @logged_in_user = logged_in_user
    @record = record
  end
  
  def index?
    logged_in_user.admin? || logged_in_user.vip?
  end

  def show?
    logged_in_user.admin? || logged_in_user.id == record.try(:user_id) || 
    logged_in_user.vip? || record.viewers.include?(logged_in_user) ||
    logged_in_user == record
  end

  def update?
    logged_in_user.admin? || logged_in_user == record || logged_in_user.id == record.try(:user_id)
  end

  def destroy?
    logged_in_user.admin? || logged_in_user == record
  end

  def create?
    logged_in_user == record
  end





end