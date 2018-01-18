class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit  # add this line
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
