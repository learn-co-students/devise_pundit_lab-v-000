class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		if !policy(@user).show?
			flash[:alert] = "Access denied."
			redirect_to users_path
		end
	end
end
