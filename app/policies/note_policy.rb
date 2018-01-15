class NotePolicy < ApplicationPolicy
	def update?
		user.admin? || user.moderator? || record.try(:user) == user
	end

	# def permitted_attributes
 #       if user.admin? || user.owner_of?(post)
 #          [:title, :body, :tag_list]
 #       else
 #          [:tag_list]
 #       end
 #     end
end
