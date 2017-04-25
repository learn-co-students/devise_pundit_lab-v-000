class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
    if current_user != @user
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

end
