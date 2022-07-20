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
      session[:user_id] = new_user.id
      cookies[:authorized] = {value: 1, expires: 1.hour}
      flash[:success] = "Welcome, #{new_user.email}!"
      redirect_to "/users/#{new_user.id}" ## maybe direct to login path here
    else
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to register_path
    end
  end

  def login_form
    render :partial => 'login_form.html.erb'
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to login_path
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:authorized] = {value: 1, expires: 1.hour}
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
