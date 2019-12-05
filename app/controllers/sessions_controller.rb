# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = if !params[:user_id]&.empty?
              User.find_by(id: params[:user_id])
            elsif !params[:name]&.empty?
              User.find_by(name: params[:name])
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
