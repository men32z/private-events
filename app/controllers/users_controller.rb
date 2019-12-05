# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = 'User Created'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Some Errors in Form'
      render 'new'
    end
  end

  def show
    @user = params[:id] ? User.find_by(id: params[:id]) : nil
    if @user
      @created_upcoming_events = @user.events.upcoming
      @created_past_events = @user.events.past
      @attended_upcoming_events = @user.attended_events.upcoming
      @attended_past_events = @user.attended_events.past
    else
      flash[:danger] = 'User not found'
      redirect_to home_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
