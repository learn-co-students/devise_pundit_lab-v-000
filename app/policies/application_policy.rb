class ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)
    @user = user
    @record = record
  end
  def show?
    scope.where(:id => record.id).exists?
  end
end
