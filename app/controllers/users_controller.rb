class UsersController < ApplicationController
	def new
	end

	def create
		@user = User.create(email: params[:email], password: params[:password])
		if @user.save
			redirect_to user_path(@user)
		end
	end

	def index
		@user = current_user
		@users = User.all
		authorize @user 
	end

	def show
		@user = User.find(params[:id])
		authorize @user
	end	

	def destroy
		@user = User.find(params[:id])
		@user.destroy!
	end
end