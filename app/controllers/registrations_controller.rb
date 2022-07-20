class RegistrationsController < ApplicationController
    def new
        user = User.new
    end 

    def create
        user = User.new(user_params)
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to dashboard_path, notice: "#{user.email} Registered Successfully!"
        else
            render :new
        end
    end

    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end
# user = User.find_by(email: params[:email])
#             # .try(:authenticate, params[:password])
# if !user.nil? && user.authenticate(params[:password])
#     session[:user_id] = user.id
#     redirect_to root_path, notice: "#{user.email} logged in!"
#     # set_status => "You are an admin / moderator / etc"
# else
#     flash[:alert] = "Sorry, your credentials are bad."
#     redirect_to login_path
# end