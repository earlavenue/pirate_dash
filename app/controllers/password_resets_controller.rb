class PasswordResetsController < ApplicationController
  def new
  end

  def create
    client = Client.find_by_email(params[:email])
    if client
    client.send_password_reset
    redirect_to new_session_path, notice: "Email sent to #{client.email} with password reset instructions"
    else
      redirect_to new_session_path, notice: "Sorry, this email was not recognized"
    end
  end

  def edit
    @client = Client.find_by_password_reset_token!(params[:id])
  end

  def update
    @client = Client.find_by_password_reset_token!(params[:id])
    if @client.password_reset_sent_at < 3.days.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @client.update_attributes(params.permit![:client])
      redirect_to new_session_path, notice: "Password has been reset."
    else
      render :edit
    end
  end


end
