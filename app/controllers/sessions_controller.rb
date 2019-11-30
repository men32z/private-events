class SessionsController < ApplicationController
  def destroy
    sign_out
    redirect_to home_path
  end
end
