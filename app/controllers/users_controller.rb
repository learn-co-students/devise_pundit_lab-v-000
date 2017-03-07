class UsersController < ApplicationController

  def index
   @users = User.all
  end

  def show
  	@user = User.find_by(id: params[:id])
  	  if !policy(@user).show?
  	  	redirect_to :back, :alert => "Access denied."
      end  
  	  authorize @user
  end


end