class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
    #authorize
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
