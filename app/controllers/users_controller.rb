class UsersController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def create
  end

  def new
  end

  def update
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
  end

private

  def user_not_authorized
    flash[:error] = "Access denied."
    redirect_to(request.referrer || root_path)
  end

end
