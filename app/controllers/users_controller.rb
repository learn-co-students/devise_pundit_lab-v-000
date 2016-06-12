class UsersController < ApplicationController
	
	def index
		@user = current_user
	end

	def show
		@user = User.find(params[:id])
		unless @user == current_user
			flash[:alert] = "Access denied."
		end
	end

	def about
		
	end

end