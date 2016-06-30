class UsersController < ApplicationController

  
 
   def edit
  end

  def destroy
   @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end
private 
 def secure_params
    params.require(:user).permit(:role)
  end

end