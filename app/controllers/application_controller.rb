class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit 

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      redirect_to '/', notice: "Access denied."
    end
end
