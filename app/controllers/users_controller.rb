class UsersController < ApplicationController

  def new
  end

  def create
  end

  def index
    @users = User.all
    authorize @users
  end

  def show
      @user = User.find(params[:id])
      unless authorize @user
        redirect_to users_path, alert: "Access denied."
      end
    end

  def update
  end

  def destroy
    @user = User.find(params[:id])
      unless authorize @user
        redirect_to users_path, alert: "Access denied."
      end
  end

private
  def secure_params
    params.require(:user).permit(:role)
  end


end
