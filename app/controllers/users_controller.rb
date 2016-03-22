class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@user = current_user
  	#authorize User
  end

  def new
  end

  def create
  end

  def show
  	@user =current_user
  	@profile_owner = User.find_by(id: params[:id])
  	if @user != @profile_owner
  	  redirect_to root_path, alert: "Access denied."
  	end 
  end

  def edit
  end

  def upate
  end

  def destroy
  end


end
