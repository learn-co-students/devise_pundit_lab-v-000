class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
   user.admin?
  end

  def update?
       user.admin? || record == user
     end


     def destroy?
      user != record
     end

end
