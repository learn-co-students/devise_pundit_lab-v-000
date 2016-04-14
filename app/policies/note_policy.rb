class NotePolicy < ApplicationPolicy


  def index?
    privileges?
  end

  def show?
    privileges? || record.user == user || record.readers.include?(user)
  end

  def create?
    user.persisted?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? || record.user == user
  end

  private

    def privileges?
      user.admin? || user.vip?
    end

end