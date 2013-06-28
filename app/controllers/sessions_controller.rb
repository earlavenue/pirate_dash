class SessionsController < ApplicationController
  def new
  end

  def create
    u = User.find_by_email(params[:email])
    if u.present? && u.authenticate(params[:password])
      session[:user_id] = u.id
      redirect_to dashboard_url
    else
      redirect_to new_session_url, notice: 'Incorrect login info'
    end
  end

  def destroy
    reset_session
    redirect_to new_session_url, notice: 'Signed out'
  end
end
