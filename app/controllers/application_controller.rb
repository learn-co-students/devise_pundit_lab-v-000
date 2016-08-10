class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :rescue_from_pundit
  protect_from_forgery with: :exception

  def rescue_from_pundit(exception)
    flash[:alert] = "Access denied."
    redirect_to(request.referrer || root_path)
  end
end
