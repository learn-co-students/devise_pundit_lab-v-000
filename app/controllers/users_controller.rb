class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless authorize @user
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

end