# frozen_string_literal: true

module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= (session[:user_id] ? User.find(session[:user_id]) : nil)
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
    @current_user = nil
  end
end
