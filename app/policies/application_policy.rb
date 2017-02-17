class ApplicationPolicy
  def initialize(user, note)
    @current_user = user
    @note = note
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

class Scope
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def resolve
    if @user.admin?
      scope.all
    else
      scope.where(user_id: @user.id)
    end
  end
end
end
