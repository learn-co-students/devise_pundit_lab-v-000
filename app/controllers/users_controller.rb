class UsersController < ApplicationController

	def index
	  @user = current_user
	end

	def show
	@user = User.find(params[:id])
      if !current_user.admin? && current_user != @user 
        flash[:warning] = "Access denied."
        redirect_to '/'
      end
	end
end
