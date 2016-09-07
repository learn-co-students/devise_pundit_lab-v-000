class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user != current_user
      flash[:alert] = "Access denied."
      redirect_to '/'
    end
  end
end
