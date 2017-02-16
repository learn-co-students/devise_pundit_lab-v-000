class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = policy_scope(User)
    #User.find(params[:id])
    render plain: "Access denied." unless @user
    #@user = authorize User.find(params[:id])

  end

end
