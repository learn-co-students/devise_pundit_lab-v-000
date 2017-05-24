
class UsersController < ApplicationController

	def index
		@users = User.all
		authorize @users
	end

	def show
		set_user
		authorize @user
	end

	def edit
		set_user	
	end

	def update
		set_user
		authorize @user
		@user.update(user_params)
	end

	def destroy
		set_user
		authorize @user
		@user.destroy
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :role)
	end
end