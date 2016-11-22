class UsersController < ApplicationController
    before_filter :authenticate_user!
    
    def index
        @user = current_user
    end
    
    def show
        @user = User.find_by(id: params[:id])
        authorize @user
    end
    
    def edit
        @user = User.find_by(id: params[:id])
        authorize @user
    end
    
    def destroy
        @user = User.find_by(id: params[:id])
        authorize @user
        @user.destroy
        redirect_to root_path
    end
end
