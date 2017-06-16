class NotePolicy < ApplicationPolicy

	def index?
		current_user.admin? || current_user.moderator?
	end

	def show?
		current_user.admin? || current_user.moderator? || current_user == @model || @model.viewers.include?(current_user)
	end

	def create?
		current_user.admin? || current_user == @model
	end

	def update?
		current_user.admin? || current_user == @model
	end

	def destroy?
		# binding.pry
		current_user.admin? || current_user == @model
	end


  def permitted_attributes
  	if current_user.admin? || current_user.owner_of?(@model)
  		[:content, :visible_to]
  	end
  end
end
