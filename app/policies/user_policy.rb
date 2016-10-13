class UserPolicy < ApplicationPolicy
	attr_reader :current_user, :other_user
	def initialize(current_user, other_user)
		@current_user = current_user
		@other_user = other_user
	end

	def index?
		current_user.admin?
	end

	def show?
		current_user.admin? || current_user.try(:id) == current_user
	end

	def update?
		current_user.admin?
	end

	def destroy?
		current_user.admin?
	end
end
