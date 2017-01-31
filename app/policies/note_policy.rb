class NotePolicy < ApplicationPolicy
  
  def index?
    user.admin? || user.moderator? || record.try(:id) == user.id
  end
  
  #def show?
  #  user.admin? || record.try(:id) == user.id
  #end
  #
  #def update?
  #  user.admin?
  #end
  #
  #def destroy?
  #  user.admin?
  #end
  
end
