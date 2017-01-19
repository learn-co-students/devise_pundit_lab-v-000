class UsersController < ApplicationController
  before_action :set_user

  def new
  end

  def create
  end

  def index
    @users = User.all
  end

  def show
    check_logged_in do
      authorize @user
    end
  end

  def edit
  end

  def update
    check_logged_in do
      authorize @user
    end
  end

  def destroy
    check_logged_in do
      authorize @user
      @user.destroy
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end

  def set_user
    @user ||= User.find_by(id: params[:id])
  end
end
