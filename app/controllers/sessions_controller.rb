class SessionsController < ApplicationController
    def new
        user = User.new
    end

    def create
        user = User.find_by(email: params[:email])
                    # .try(:authenticate, params[:password])
        if !user.nil? && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to dashboard_path, notice: "#{user.email} logged in!"
            # set_status => "You are an admin / moderator / etc"
        else
            flash[:alert] = "Sorry, your credentials are bad."
            redirect_to login_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "You have been logged out"
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end