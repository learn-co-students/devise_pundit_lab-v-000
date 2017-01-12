class UsersController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])

    # unless @user.id == current_user[:id]
    #   flash[:notice] = 'Access denied.'
    #   redirect_to root_path
    # end
    
    authorize @user
  end
  
end
