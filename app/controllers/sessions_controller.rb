class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: email)
    if @user.authenticate(password)
      session[:user_id] = @user.id
      flash[:notice] = "Start Writing!"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def email
    params[:email]
  end

  def password
    params[:password]
  end
end
