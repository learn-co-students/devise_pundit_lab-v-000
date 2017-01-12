class ApplicationPolicy
  attr_reader :user, :record
  
  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Access denied." unless user
    @user = user
    @record = record
  end

end
