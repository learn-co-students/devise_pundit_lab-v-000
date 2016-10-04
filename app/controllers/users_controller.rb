class UsersController < ApplicationController
	def index
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
		redirect_to users_path, alert: "Access denied." unless current_user == @user || current_user.admin?
	end

	def destroy
		@user = User.find(params[:id])
		return redirect_to users_path, alert: "Access denied." unless current_user != @user && current_user.admin?
		@user.delete
		redirect_to root_path
	end
end
