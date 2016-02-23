class NotePolicy < ApplicationPolicy

  def show?
    user.admin? || user.vip? || record.user == user
  end 

  def create?
    user.admin? || record.user == user
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end  

  def edit?
    user.admin? || record.user == user
  end
end  