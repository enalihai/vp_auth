class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        user = User.find_by(email: params[:email])
                    .try(:authenticate, params[:password])
        if user
            session[:user_id] = user.id
            redirect_to root_path, notice: "#{user.email} logged in!"
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

    # private

    # def session_params
    #     binding.pry
    #     params.require(:session).permit(:user_id)
    # end
end