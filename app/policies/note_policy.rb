class NotePolicy < ApplicationPolicy

  # def permitted_attributes
  #   if user.admin? || user.owner_of?(record)
  #     [:content, :visible_to]
  #   end
  # end

  def create?
    user.role != "moderator" && user.persisted?
  end

  def update?
    user.admin? || record.try(:user) == user
  end

  def destroy?
    user.admin? || record.try(:user) == user
  end

  def index?
    user.admin? || user.moderator? || user
  end

  def show?
    user.admin? || user.moderator? || record.try(:user) == user || user.persisted? && record.try(:visible_to).include?(user.name)
  end

  class Scope < Scope
     def resolve
       if user.admin? || user.vip?
         scope.all
       else
         scope.where(user_id: user.id) 
         scope.includes(:readable).where(id: user.id)
       end
     end
   end
end