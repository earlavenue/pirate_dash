class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    @current_user || User.find_by_id(session[:user_id])
  end

  def require_signin
    if current_user.blank?
      redirect_to new_session_url, notice: "You are not signed in"
    end
  end

  def require_omron
    if current_user.organization.name != "Omron Fitness"
      redirect_to people_url, notice: "You are not authorized for that page."
    end
  end


end
