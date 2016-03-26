class UsersController < ApplicationController


  def index
    
  end

  def new
    
  end

  def create
    # @user = User.new(user_params)
    
  end

  def show
    if current_user.id != params[:id].to_i #change this to find user
      flash.alert = "Access denied."
      redirect_to root_path
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end





  # def user_params
  #   params.require(:user).permit(:)
  # end

end