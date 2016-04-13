class UsersController < ApplicationController
  before_action :authenticate_user! 
  # before_action :admin_only, except: :show

  def index
# byebug
    @current_user=current_user
    @users=User.all
  end

  def new
  end

  def create
  end

  def show
# byebug
    @user = User.find_by(id: params[:id]) 



  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
    # def admin_only
    #   unless current_user.admin?
    #     redirect_to root_path, :alert => "Access denied."
    #   end
    # end
end


