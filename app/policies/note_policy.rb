class NotePolicy < ApplicationPolicy


  def index?
    privileges?
  end

  def show?
    privileges? || record.user == user || record.readers.include?(user)
  end

  def create?
    !!user.id
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.vip?
        scope.all
      else
        scope.where(user_id: user.id) 
        scope.includes(:readable).where(id: user.id)
      end
    end
  end

  private

    def privileges?
      user.admin? || user.vip?
    end

end