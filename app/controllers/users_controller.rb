class UsersController < ApplicationController

    def index
        @user = current_user

    end

    def new
    end

    def create
    end


    def show
        if current_user != User.find_by(params[:id])
            redirect_to root_path, :alert => "Access denied."
        else
            @user = User.find_by(params[:id])
        end
 
    end

    def update
        @user = User.find_by(params[:id])
        
    end
end
