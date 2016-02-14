class UserPolicy < ApplicationPolicy
     def show?
       #byebug
       user.admin? || record.id == user.id
     end

     def index?
       #byebug
       user.admin?
     end

     def update?
     	user.admin?
     end

     def destroy?
     	user.admin?
     end
end