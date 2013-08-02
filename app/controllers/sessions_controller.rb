class SessionsController < ApplicationController
  def new
  end

  def create
    u = Client.find_by_email(params[:email])
    if u.present? && u.authenticate(params[:password])
      session[:client_id] = u.id
      if u.organization.name == "Omron Fitness"
        redirect_to organizations_url
      else
        redirect_to people_url
      end
    else
      redirect_to new_session_url, notice: 'Incorrect login info'
    end
  end

  def destroy
    reset_session
    redirect_to new_session_url, notice: 'Signed out'
  end
end
