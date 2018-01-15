class UsersController < ApplicationController
  
  def index
    @users = User.all 
  end

  def show 
    @user = User.find_by(id: params[:id])
    unless authorize @user
       redirect_to users_path, :message => 'Access denied.'
     end 
  end 

  def update 
    @user = User.find_by(id: params[:id])
    unless authorize @user
       redirect_to users_path, :message => 'Access denied.'
     end 
  end 

  def destroy 
    @user = User.find_by(id: params[:id])
    @user.delete 
    redirect_to users_path
  end 


end 