class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_handler

  def unauthorized_handler
    flash[:alert] = "Access denied."
    redirect_to root_path
  end
end
