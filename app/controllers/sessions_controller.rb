class SessionsController < ApplicationController
  def new

  end

  def create
    if !params[:user_id]&.empty?
      @user = User.find_by(id: params[:user_id])
    elsif !params[:name]&.empty?
      @user = User.find_by(name: params[:name])
    else
      @user = nil
    end

    if @user
      log_in(@user)
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'user not found'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to home_path
  end
end
