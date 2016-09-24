class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.all
    authorize @users
  end

  def show
    #@user = User.find_by(id: params[:id])
    if @user.present?
      authorize @user
    else
      redirect_to root_path
    end
  end

  def update
    if @user.present?
      @user.update(user_params)
    else
      skip_authorization
    end

    redirect_to users_url, notice: 'User was successfully updated.'
  end

  def destroy
    if @user.present?
      authorize @user
      @user.destroy
    else
      skip_authorization
    end

    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
