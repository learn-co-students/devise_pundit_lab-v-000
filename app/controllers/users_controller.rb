class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @user = User.find_by_id(params[:id])
    authorize @user
  end

  def edit
    @user = User.find_by_id(params[:id])
    authorize @user
  end
end
