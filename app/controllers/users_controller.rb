class UsersController < ApplicationController

	include Pundit

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action. Access denied."
    	redirect_to(request.referrer || root_path)
	end

	def index
		authorize User
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		authorize @user
	end

	def update
		@user = User.find(params[:id])
		authorize @user
		if @user.update_attributes(permitted_attributes(@user))
		  redirect_to @user
		else
		  render :edit
		end
	end

end