class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user

  rescue Pundit::NotAuthorizedError
    flash[:notice] = "Access denied."
      redirect_to action: :index
  end
end
