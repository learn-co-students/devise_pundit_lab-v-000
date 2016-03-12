class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_user

  private

    def unauthorized_user#(exception)
      flash[:error] = "Access denied."
      redirect_to(request.referrer || root_path)
    end
end
