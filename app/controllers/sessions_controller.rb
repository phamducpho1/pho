class SessionsController < ApplicationController
  def new; end

  def remember_params user
    params[:session][:remember_me] == Settings.sessions.check ? remember(user) : forget(user)
  end

  def message_account user
    log_in user
    remember_params user
    redirect_to root_url
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      message_account user
    else
      flash.now[:danger] = t "users_controller.sign_up"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
