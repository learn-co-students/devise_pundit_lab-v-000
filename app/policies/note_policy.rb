class NotePolicy < ApplicationPolicy
  
  def index?
    user.admin? || user.moderator? || user.id == 1001
  end
  
  def edit?
    #binding.pry
    user.admin? || user.id == 1005
  end
  
  def destroy?
    user.admin? || user.id == 1009
  end
  
  def show?
    user.admin? || user.id == 1013
  end
  
  def update?
    user.admin? || user.id == 1017
  end
  
  
end
