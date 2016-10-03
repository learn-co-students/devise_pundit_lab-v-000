class NotePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin?
        scope
      else
        scope.where(user: user)
      end

      # if user.admin? && scope != user.notes
      #   scope
      # else
      #   user.notes
      # end
    end
  end

  # def index?
  #   binding.pry
  #   record.try(:user) == user || user.admin?
  # end

  # def new?
  #   record.try(:user) == user || user.admin?
  # end

  def create?
    record.try(:user) == user || user.admin?
  end

  def show?
    record.try(:user) == user || record.readers.include?(user) || user.admin?
  end

  # def edit?
  #   record.try(:user) == user || user.admin?
  # end

  def update?
    record.try(:user) == user || user.admin?
  end

  def destroy?
    record.try(:user) == user || user.admin?
  end

end


# Hey Mendel, hope you’re doing well.  For Thursday’s Devise/Pundit study group, I had a specific question I was hoping to ask but it's not necessarily built into the lab itself. I tried to add a few different features on top of the lab’s requirements and eventually ran into trouble with nested resources and specifically the index action.
#
# To summarize:
# In my routes.rb file, I nested notes resources inside of users resources and wanted to display all notes for a single user in their /users/:user_id/notes index page, while restricting the page's access to only that specific user or an admin.
#
# Using a policy_scope inside the controller, I used @notes = policy_scope(Note.all) but ran into trouble inside of the NotePolicy.
#
#
#
# app/controllers/notes_controller.rb
# class NotesController < ApplicationController
#   def index
#     @notes = policy_scope(Note.all)
#
# app/policies/note_policy.rb
# class NotePolicy < ApplicationPolicy
#   class Scope < Scope
#     def resolve
#       if user.admin?
#         #an admin can view all notes from the db
#         scope.all
#       else
#         #a user can view all of their notes
#         scope.where(user_id: user.id)
#       end
#     end
#   end
#
#
# However rather than displaying all notes in the db, I wanted the admin to see a list of notes from a specific user.  So for example if an admin visited a user at www.example.com/users/5/notes, I was looking for a way to create a query like this - scope.where(user_id: params[user_id]).  Unfortunitley with pundit, there's no easy way of passing in an additional value like params or at least I haven't found a way.
#
# The solutions I've found all seem to add excess bloat to my NotesController which I wanted to avoid if possible, just not sure how in this case.
#
# Again I realize this isn't necessarily related to the lab but was hoping we could discuss a solution if we had time at the end.
#
# Thanks and sorry for the long email!!!
#
#
#
#
#
#
#
#
# if an admin visited someones elses,
#
#
#
#
#
# and within the then query scope.all (for a list of every note in the db or scope.where(user_id: user.id) to list all (but bc there’s no easy way to pass params to a policy, it was difficult to give an admin access to another user’s id (to get a list of their notes).
