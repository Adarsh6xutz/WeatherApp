# frozen_string_literal: true
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      # Save the user_id in the session
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :login_form
    end
  end

  def destroy_session
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
