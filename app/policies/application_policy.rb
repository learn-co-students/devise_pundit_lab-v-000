class ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)
    @user = user
    @record = record
  end
  def index?
    user.admin?
  end
  def show?
    user == record || user.admin?
  end
  def update?
    user == record || user.admin?
  end
  def destroy?
    user.admin? && (record != user)
  end
end
