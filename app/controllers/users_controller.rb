class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user= User.all
    if user_signed_in? ## Learn expert instructed me to add a check here
       # to set @current_user because for some reason current_user was broken in views
      @current_user = current_user
     end
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    redirect_to users_path, alert: "Access denied." unless current_user == @user
  end


end
