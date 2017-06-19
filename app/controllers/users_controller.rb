class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    redirect_to :back, :alert => "Access denied." if !@user
  end
end
