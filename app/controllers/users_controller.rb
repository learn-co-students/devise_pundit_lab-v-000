class UsersController < ApplicationController
  before_action :authenticate_user!
  

  def index
    
    @users = User.all
    authorize User
  end

  def new

  end

  def create

  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
       unless @user == current_user || current_user.try(:admin?) 
         redirect_to root_path, notice: "Access denied."
       end
     else
       redirect_to root_path, notice: "Access denied."
     end

  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    authorize @post
  if @user.update(user_params)
    redirect_to @user
  else
    render :edit
  end

  end

  def destroy
    binding.pry
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."

  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
