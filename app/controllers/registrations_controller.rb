class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
       @user = User.new(user_params)
       if @user.save
        # session[:user_id] = @user.id #to check if logged in
        redirect_to sign_up_path, notice: "Successfully created account"
       else
            render :new, status: 422
       end
    end


    private

    def user_params
        params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation, :role)
    end
end