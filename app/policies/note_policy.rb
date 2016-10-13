class NotePolicy < ApplicationPolicy
	attr_reader :note, :current_user
	def initialize(note, current_user)
		@note = note
		@current_user = current_user
	end

	# class Scope
 #    attr_reader :user, :scope

 #    def initialize(user, scope)
 #      @user  = user
 #      @scope = scope
 #    end

 #    def resolve
 #      if user.admin?
 #        scope.all
 #      else
 #        scope.where(user_id: current_user.id).or(readers: current_user)
 #      end
 #    end
 #  end

	def index?
		current_user.admin?
	end

	def create?
	end

	def 

	def show?
		current_user.admin? || current_user.owner_of?(note) || note.visible_to.includes?(current_user)
	end

	def update?
		current_user.admin?
	end

	def destroy?
		current_user.admin?
	end
end
