class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :authenticate_user!, except: [:index, :create, :new]
    before_action :admin_only, only: [:update, :destroy]
    
    def index
        @users = User.all
        @current_user = current_user
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to @user
        else
            render :new
        end
    end

    def show
        if !current_user.admin? && current_user != @user
            redirect_to :back, alert: "Access denied."
        end
        @current_user = current_user
    end

    def edit
    end

    def update
        @user.assign_attributes(user_params)
        if @user.save
            redirect_to @user
        else
            render :edit
        end
    end

    def destroy
        @user.destroy
        redirect_to users_path
    end

    private

    def set_user
        @user = User.find_by(id: params[:id])
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def admin_only
        redirect_to users_path unless current_user.admin?
    end
end
