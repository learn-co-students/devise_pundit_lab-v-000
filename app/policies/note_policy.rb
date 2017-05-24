class NotePolicy < ApplicationPolicy


	def create?
		record == user
	end

	def show?
		user.admin? || user.moderator? || record == user || user.reader?
	end

	def update?
		user.admin? || record == user
	end

	def destroy?
		user.admin? || record == user
	end
end	