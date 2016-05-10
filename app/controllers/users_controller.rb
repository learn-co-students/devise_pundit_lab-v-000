class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  # def destroy
  #    @user = User.find(params[:id])
  #    @user.destroy
  #
  #    if @user.destroy
  #        redirect_to root_url, flash[:notice] = "User deleted."
  #    end
  #  end


  private

  def require_login
    redirect_to new_user_session_path unless current_user
  end

end
