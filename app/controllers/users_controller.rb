# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # def new
    # @user = User.new
  # end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  # def create
    # user = User.new(user_params) 
    # if user.save
    #   redirect_to dashboard_path, notice: "Welcome back, #{user.name}!"
    # else
    #   redirect_to register_path, notice: "Sorry, your credentials are bad."
    # end
  # end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
# def login
  #   user = User.find_by(email: params[:email])
  #   if !user.nil? && user.authenticate(params[:password])
  #     session[:user_id] = user.id
  #     cookies.encrypted[:authorized] = 1
  #     flash[:success] = "Welcome, #{user.email}!"
  #     redirect_to "/users/#{user.id}"
  #   else
  #     flash[:error] = "Sorry, your credentials are bad."
  #     redirect_to login_path
  #   end
  # end
   # def login_form
  #   render :partial => 'login_form.html.erb'
  # end
