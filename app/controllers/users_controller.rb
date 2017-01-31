class UsersController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = User.all
  end

  def new
  end

  def create
    User.create(user_params)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def users_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def user_not_authorized(exception)
    flash[:error] = 'Access denied.'
    redirect_to(request.referrer || root_path)
  end
end
