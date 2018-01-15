class UsersController < ApplicationController
	before_action :set_user!, only: [:show, :update]
    def show
     (redirect_to root_path, alert: "Access denied.") unless current_user == @user || current_user.admin?
    end
 
    def index
     @users = User.all
    end
  
    def destroy
      session.clear
    end
	private 
	 def set_user!
     @user = User.find(params[:id])
     end
end 