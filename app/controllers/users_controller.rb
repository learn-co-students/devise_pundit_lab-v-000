class UsersController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to(request.referrer || root_path)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

end
