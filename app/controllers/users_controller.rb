class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # after_action :verify_authorized

  def index
    authorize User
    @users = User.all
  end

  def show
    authorize @user
  end

  def edit
  end

  def update
    authorize @user
    @user.update(user_params)
  end

  def destroy
    authorize @user
    @user.delete
  end

  private
    def user_params
      params.require(:user).permit(:subject)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end