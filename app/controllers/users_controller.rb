class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize User
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    authorize(User).find(params[:id]).update(get_params)
  end

  def destroy
    authorize(User).find(params[:id]).delete
  end

  private

  def get_params
    params.require(:user).permit(:subject)
  end
end
