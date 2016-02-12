class UsersController < ApplicationController
  before_action :set_user, only:[:show, :update, :destroy]
  
  def index
    @users = User.all
  end

  def show
    redirect_to root_path, alert: "Access denied."  unless authorize(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end