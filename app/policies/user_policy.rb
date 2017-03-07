require 'pry'

class UserPolicy < ApplicationPolicy
    
    def index?
        binding.pry
        user.admin?
    end
    
    def show?
        binding.pry
        user.admin? || record.try(:user) == user
    end
    
    def create?
    end
    
    def update?
        user.admin?
    end
    
    def destroy?
        user.admin?
    end
end
