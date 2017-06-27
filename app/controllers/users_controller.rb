class UsersController < ApplicationController

  def index
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to root_path, :alert => "Access denied." if @user != current_user
    # authorize @user
  end
  
end
