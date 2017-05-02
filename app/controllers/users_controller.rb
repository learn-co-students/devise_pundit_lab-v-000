class UsersController < ApplicationController
 before_action :set_user, except:[:index]


  def index
    @users = User.all
  end


  def show
    if !authorize @user
    flash[:alert] = "Access denied."
  end
  end


  def update
    authorize @user
  end

  def destroy
    authorize @user
  end



private

  def set_user
    @user = User.find(params[:id])
  end

end
