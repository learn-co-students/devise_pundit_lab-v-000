require 'pry'

class NotePolicy < ApplicationPolicy
    
  def new?
    true
  end

  def create?
    true
  end

  def index?
    user.admin? || user.moderator? 
  end
    
  def show?
    user.admin? || user.moderator? || record.try(:readers).include?(user)    
  end
    
  def edit?
    user.admin? || record.try(:user) == user
  end

  def update?
    user.admin? || record.try(:user) == user
  end
    
  def destroy?
    user.admin? || record.try(:user) == user
  end
    
end
