class UsersController < ApplicationController
    before_filter :authenticate_user!
    def index
        @users = User.all
        authorize @users
    end
    def new
        @user = User.new
        authorize @user
    end
    def create
        @user = User.new(user_params)
        authorize @user
        if @user.save
            redirect_to users_path
        else
            render :new
        end
    end
    def show
        @user = User.find(params[:id])
        authorize @user
    end
    def update
        @user = User.find(params[:id])
        authorize @user
    end
end
