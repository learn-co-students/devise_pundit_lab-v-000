class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    authorize @user
  end

  def update
  end

  def destroy
  end

end
