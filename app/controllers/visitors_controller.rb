class VisitorsController < ApplicationController
  before_action :check_login

  private
    def check_login
      if signed_in?
        redirect_to notes_path
      end
    end

end
