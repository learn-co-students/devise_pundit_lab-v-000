class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    unless authorize @user 
    redirect_to root_path, :alert => "Access denied."
      end
    end



  def index
    @users = User.all
  end

end
