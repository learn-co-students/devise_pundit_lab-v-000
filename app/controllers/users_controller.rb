class UsersController < ApplicationController
  
  
  def show
    @user=User.find(params[:id])
    authorize @user
  end

  def index
    @user=current_user
  end

  private

  def user_params
    params.require(:user).permit()
  end
end
