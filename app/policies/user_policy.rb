class UserPolicy < ApplicationPolicy
	def index?
		@user.admin?
	end

	def show?
		@user.admin? || @record == @user
	end

	def update?
		@user.admin?
	end

	def destroy?
		@user.admin? unless @record == @user
	end

	def permitted_attributes
		if @user.admin?
			[:name, :email, :role]
		end
	end

end
