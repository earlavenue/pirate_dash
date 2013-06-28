class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user || User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def require_signin
    if current_user.blank?
      redirect_to new_session_url
    end
  end
end
