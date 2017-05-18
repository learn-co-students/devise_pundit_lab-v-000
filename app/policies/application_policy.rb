class ApplicationPolicy
	# def initialize(user, note)
	# 	@user = user
	# 	@note = note
	# end 

	def initialize(user, record)
	    #raise Pundit::NotAuthorizedError, "must be logged in" unless user
	    @user   = user
	    @record = record
    end
end
