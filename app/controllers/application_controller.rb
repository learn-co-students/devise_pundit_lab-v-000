class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # otherwise "user signs out successfully" feature test doesn't pass
  def after_sign_out_path_for(resource)
    new_user_session_path
  end  

  private

    def user_not_authorized
    	flash[:alert] = "Access denied."
    	redirect_to(request.refferer || root_path)
    end
end
