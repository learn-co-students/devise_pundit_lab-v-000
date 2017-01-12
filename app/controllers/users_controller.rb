class UsersController < ApplicationController


  def index
    @users = User.all
    authorize User
  end

  def new
  end

  def create

  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, alert: "Access denied."
      end
    end
  end

  def edit

  end

  def update

    @user = User.find(params[:id])
    authorize @user
  end

  def destroy

    @user = User.find(params[:id])
    authorize @user
  end

end