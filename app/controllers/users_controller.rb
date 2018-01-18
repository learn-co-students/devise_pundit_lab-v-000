class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    # @user = current_user
    @user = User.find(params[:id])
     if !current_user.admin? && current_user != @user
       redirect_to root_path, :alert => "Access denied."
     end
  end

  def about
  end
end
