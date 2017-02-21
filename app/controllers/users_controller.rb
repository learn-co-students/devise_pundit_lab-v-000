class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def update
    @user = User.find_by(id: params[:id])
    if authorize @user
      @user.update(permitted_attributes)
      redirect_to user_path(@user)
    else
      redirect_to '/'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if authorize @user
      @user.destroy
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

end
