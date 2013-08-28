class MembershipsController < ApplicationController
  require 'openssl'

  def handshake
    @membership = Membership.new
    encrypted_and_encoded = Base64.encode64(params[:secret_user_id]).encode('utf-8')
    session[:secret_user_id] = encrypted_and_encoded
  end

  def handshake_retake
    @membership = Membership.new
  end

  def create
    correct_organization = Organization.find_by_code(params[:membership][:organization_id])
    if correct_organization
      user_id = Membership.decode_user_id(params[:membership][:person_id])
      @person = Person.find(user_id)
      @membership = Membership.find_by_person_id(user_id) || Membership.new
      @membership.person_id = user_id
      @membership.organization_id = correct_organization.id
      respond_to do |format|
        if @membership.save
          format.js
          format.html { redirect_to people_url, notice: "Thanks for connecting to CW Dash! We're sending you back to your Omron Fitness profile now." }
        else
          format.js { render :js => "window.location.href='#{handshake_retake_path}'" }
          format.html { redirect_to(handshake_retake_path) }
        end
      end
    else
      respond_to do |format|
        format.js { render :js => "window.location.href='#{handshake_retake_path}'" }
        format.html { redirect_to(handshake_retake_path) }
      end
    end
  end

  def update
    correct_organization = Organization.find_by_code(params[:membership][:organization_id])
    if correct_organization
      user_id = Membership.decode_user_id(params[:membership][:person_id])
      @person = Person.find(user_id)
      @membership = Membership.find_by_person_id(user_id) || Membership.new
      @membership.person_id = user_id
      @membership.organization_id = correct_organization.id
      respond_to do |format|
        if @membership.save
          format.js
          format.html { redirect_to people_url, notice: "Thanks for connecting to CW Dash! We're sending you back to your Omron Fitness profile now." }
        else
          format.js { render :js => "window.location.href='#{handshake_retake_path}'" }
          format.html { redirect_to(handshake_retake_path) }
        end
      end
    else
      respond_to do |format|
        format.js { render :js => "window.location.href='#{handshake_retake_path}'" }
        format.html { redirect_to(handshake_retake_path) }
      end
    end
  end

end
