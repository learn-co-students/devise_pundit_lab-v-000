class UserPolicy

  def index?
    user.admin?
  end

  def show?
    record == user || user.admin?
  end

  def update?
    record == user || user.admin?
  end

  def destroy?
    record != user || user.admin?
  end


end ## class end