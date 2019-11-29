class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        log_in(@user)
        flash[:success] = "User Created"
        redirect_to users_path @user
      else
        flash.now[:danger] = 'Some Errors in Form'
        render 'new'
      end
  end

  def show
    @user = User.find(session[:user_id])
    redirect_to new_users_path if !@user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
