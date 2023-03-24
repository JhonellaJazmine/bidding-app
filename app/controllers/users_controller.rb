class UsersController < ApplicationController
    before_action :set_user, only: %i[show edit update destroy]
    
    def index
        @users = User.all.order(:id)
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save 
            redirect_to users_path, notice: 'User has been created successfully.'
        else
            render :new, status: 422
        end
    end
    
    def show 
    end
    
    def edit 
    end
    
    def update
    if @user.update(user_params)
        redirect_to users_path, notice: 'User has been updated successfully.'
    else
        render :edit, status: 422
    end
    end
    
    def destroy
    @user.destroy
    redirect_to users_path, notice: 'User has been deleted successfully.'
    end
    
    
    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    end