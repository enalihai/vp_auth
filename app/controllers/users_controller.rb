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
    new_user.save
    new_user[:email] = new_user[:email].downcase
    flash[:success] = "Welcome, #{new_user.email}!"
    redirect_to "/users/#{new_user.id}"
    # else
    #   redirect_to root_path, notice: 'A required field was missing or email is already in use'
    # end
  end

  def login_form
    render :partial => 'login_form.html.erb'
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.save
      flash[:success] = "Welcome, #{user[:email]}!"
      redirect_to "/user/#{user.id}"
    else 
      redirect_to login_path
      flash[:error] = "Invalid Credentials"
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
      flash[:success] = "Welcome, #{user.email}!"
    else
      redirect_to login_path
      flash[:error] = "Sorry, your credentials are bad."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
