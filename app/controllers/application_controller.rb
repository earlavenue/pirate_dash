class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_client

  def current_client
    @current_client || Client.find_by_id(session[:client_id])
  end

  def require_signin
    if current_client.blank?
      redirect_to new_session_url, notice: "You are not signed in"
    end
  end

  def require_omron
    if current_client.organization.name != "Omron Fitness"
      redirect_to people_url, notice: "You are not authorized for that page."
    end
  end


end
