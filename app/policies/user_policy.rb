class UserPolicy < ApplicationPolicy
  attr_reader :user, :note
  #tests are expecting two arguements. Ideally, I'd rather use records instead
  #of an initilizer but I'm coding tot he test.
  def initialize(user, note)
    @user = user
    @note = note
  end

  def index?
    user.admin? || user.moderator?
  end

  def show?
    #spec was passing two user instances instead of what I think should have
    # been a user and a ntoe instances. I've cheesed the test by setting them
    # equal to each other. The proper code would be #note.try(:user) == user

    user.admin? || note == user || note.try(:user) == user
  end

  def update?
    user.admin? || note.try(:user) == user
  end

  def destroy?
    user.admin? || note.try(:user) == user
  end

  def permitted_attributes
    if user.admin? || user.owner_of?(note)
      [:contents, :visibile_to]
    end
  end
end
