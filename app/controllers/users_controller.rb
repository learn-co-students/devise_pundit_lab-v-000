class UsersController < ApplicationController  
  before_action :authenticate_user!
  before_action :set_user, except: [:index]

  def index
    @user = current_user
    authorize @user
  end  

  def show    
    authorize @user
  end

  def update
    authorize @user
    @user.update(user_params)
  end

  def destroy
    authorize @user
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end

end
