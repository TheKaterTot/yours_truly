class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def require_login
    unless session[:user_id]
      flash[:error] = "You must be signed in to view that page"
      redirect_to root_path
    end
  end
end
