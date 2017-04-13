require 'pry'
class UserPolicy < ApplicationPolicy
    attr_reader :user, :user_model
    
    def initialize(user,user_model)
        @user = user
        @user_model = user_model
    end
    
    def show?
       @user.admin? || @user.moderator? || @user == @user_model 
    end
    def create?
        @user.admin?
    end
    def index?
        @user.admin?
    end
    def update?
       @user.admin? 
    end
    def destroy?
        @user.admin? || @user == @user_model 
    end
end
