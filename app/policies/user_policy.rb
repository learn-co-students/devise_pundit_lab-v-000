class UserPolicy < ApplicationPolicy

  # def update?
  #   user.admin?
  # end

  def index?
    user.admin?
  end
  def show?
   record == user || user.admin?
 end

 def update?
   record == user || user.admin?
 end

 def destroy?
   user.admin? && (record != user)
 end
end
