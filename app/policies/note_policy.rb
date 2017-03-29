class NotePolicy < ApplicationPolicy

  def index?
    user.try(:admin?) || record.try(:readers).include?(user) unless record.try(:readers) == nil || use
  end

  #def create?
    #I don't really need this policy
  #  user.admin? || record == user
  #end

  def update?

      user.try(:admin?) || user.try(:notes).include?(record)

    # remember, we had to switch this around from looking for record.user == user to ^^^^
    # there's always the opposite way of approaching the probem
  end

  def destroy?
    #binding.pry

      user.try(:admin?) || user.try(:notes).include?(record)

  end



end
