class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  # In users#show we call 'authorize @user' which throws this not authorized error
  # instead we'll use this method to show a flash error
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(error)
    flash[:error] = "Access denied."
    redirect_to root_path
  end
end
