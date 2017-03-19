class UsersController < ApplicationController
  
  def index
    @users = User.all 
  end

  def show 
    @user = User.find_by(id: params[:id])
    authorize @user
      # redirect_to root_path, :message => 'Access denied.'
  end 


end 