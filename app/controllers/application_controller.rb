class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception

  # NOTE: authenticate_user! ensures a logged in user is available to all, or a specified set of controller actions (devise method).
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # NOTE: Redirect to a specific page after a successful sign in & sign out
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  def after_sign_out_path_for(resource)
    new_user_session_path
  end


  private

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to(request.referrer || root_path)
    end

end
