class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, except: [:index, :new]
  


  def index
    @users=User.all
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create

  end

  def show
    redirect_to :back, alert: "Access denied." unless UserPolicy.new(current_user, @user).show?
    # @user=User.find_by(id: params[:id])
  end

  def edit
    authorize @user
  end

  def update
  end

  def destroy
    authorize @user
  end

  private
    def set_user
      @user=User.find_by(id: params[:id])
    end



end