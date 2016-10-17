class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pundit
  protect_from_forgery with: :exception

  private
  def set_current_user
    @current_user = current_user
  end

  def user_not_authorized
    flash[:warning] = "Access denied."
    redirect_to(request.referrer || root_path)
  end

end
