class UserPolicy < ApplicationPolicy
	attr_accessor :current, :user
	
	def initialize(current, user)
    	@current = current
    	@user = user
  	end

  	def index? 
  		current.admin?
  	end

  	def update?
  		current.admin?
  	end

  	def destroy?
  		current.admin?
  	end

	def show?
		current.admin? || current.moderator? || user.id == current.id
	end
end
