class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_user!, except: [:index]

  def index
    @users = User.all
    #unless current_user.admin?
    #  redirect_to user_path(current_user)
    #end
  end

  def show
    #unless current_user.admin? || current_user == @user
    #  redirect_to :back, alert: "Access denied."
    #end
    authorize @user
  end

  private

  def set_user!
    @user = User.find_by(id: params[:id])
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to root_path
  end
end
