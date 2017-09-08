class UsersController < ApplicationController

  skip_after_action :verify_policy_scoped, except: [:index]

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def update
    user = User.find_by(id: params[:id])
    authorize user
  end

  def index
    @users = policy_scope(User)
    authorize @users
  end
  
end