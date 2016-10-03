class PagesController < ApplicationController
  # NOTE: Turn off user authentication for all actions in this controller.
  skip_before_action :authenticate_user!

  def about
  end

  def home
  end
end
