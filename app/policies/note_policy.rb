class NotePolicy < ApplicationPolicy
	def create?
		@user == @record.user
	end

	def edit?
		@user.admin? || @user == @record.user
	end

	def update?
		@user.admin? || @user == @record.user
	end

	def destroy?
		@user.admin? || @user == @record.user
	end

	def show?
		@user.admin? || @user.moderator? || @record.user == @user || @record.readers.include?(@user)
	end

	class Scope

		attr_reader :user, :scope

	    def initialize(user, scope)
	      @user  = user
	      @scope = scope
	    end

		def resolve
			if user.admin? || user.moderator?
				scope.all
			else
				viewable_notes = []
				scope.each do |note|
					binding.pry
					viewable_notes << note if note.user == user || note.readers.include?(user)
				end
				viewable_notes
			end
		end
	end
end