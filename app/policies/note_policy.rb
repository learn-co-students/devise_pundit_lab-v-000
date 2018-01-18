class NotePolicy < ApplicationPolicy
	class Scope < Scope
    def resolve
      if user.admin? || user.vip?
        scope.all
      else
        scope.where(readers: [user])
      end
    end
  end


  def show?
  	user.admin? || user.vip? || record.try(:user) == user || record.readers.include?(user)
  end

	def create?
		user.admin? || record.try(:user) == user
	end

  def edit?
    user.admin? || record.try(:user) == user
  end

	def update?
		user.admin? || record.try(:user) == user
	end

	def destroy?
		user.admin? || record.try(:user) == user
	end





end