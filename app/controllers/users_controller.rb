class UsersController < ApplicationController

  def index
    @users = policy_scope(User)
    #authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    unless authorize @user
      flash.now[:alert] = "Access denied."
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(permitted_attributes(@user))
      flash[:success] = 'Profile Updated.'
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Profile not updated."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    flash[:success]= "User deleted."
    redirect_to users_path
  end

end
