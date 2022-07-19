# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  def create
    new_user = User.new(user_params) 
    if new_user.save
      flash[:success] = "Welcome, #{new_user.email}!"
      redirect_to "/users/#{new_user.id}"
    else
      redirect_to register_path, notice: 'A required field was missing or email is already in use'
    end
  end

  def login_form
    render :partial => 'login_form.html.erb'
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.save
      redirect_to "/user/#{user.id}"
      flash[:success] = "Welcome, #{user[:email]}!"
    else 
      redirect_to login_path
      flash[:error] = "Invalid Credentials"
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
