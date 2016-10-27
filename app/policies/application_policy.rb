class ApplicationPolicy
attr_reader :user, :record 
#I used this website: https://www.sitepoint.com/straightforward-rails-authorization-with-pundit/
#to help figure out how to set up a basic ApplicationPolicy.
  def initialize(user, record)
    @user = user
    @record = record
  end 

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create
    false
  end

  def new
    create?
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
      scope
    end 

  end 

end
