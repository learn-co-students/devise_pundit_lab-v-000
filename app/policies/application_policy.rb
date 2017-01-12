class ApplicationPolicy
  attr_accessor :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_accessor :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scopeend
    end
  end
end
