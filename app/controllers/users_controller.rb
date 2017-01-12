class UsersController < ApplicationController
=begin
  def index
    @user = User.all
    authorize User
  end

  def update
    @user = User.find(params[:id])
    authorize User
  end
=end

  def index
     @users = User.all
   end
 
   def show
    @user = User.find_by(id: params[:id])
    if !current_user.admin? && current_user != @user
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
   end
end