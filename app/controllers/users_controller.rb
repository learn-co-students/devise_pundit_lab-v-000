class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:sign_in]

  def index
    @users = User.all
      # @user ||= current_user
      # authorize @user
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Access denied." unless current_user == @user
  end

  # def edit
  #   @user = User.find(params[:id])
  #   authorize @user
  # end
  def new
  end

  def update
    @user = User.find(params[:id])
    # @user.save
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
  end


end
