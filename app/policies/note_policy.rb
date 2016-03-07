class NotePolicy < ApplicationPolicy

	def create?
		user.admin? || record.user == user
	end

end