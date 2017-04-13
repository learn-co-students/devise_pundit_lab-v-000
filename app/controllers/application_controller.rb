class ApplicationController < ActionController::Base
    include Pundit
    protect_from_forgery with: :exception
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    def user_not_authorized
        redirect_to root_path, notice: "Access denied."
    end
end
