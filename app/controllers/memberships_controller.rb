class MembershipsController < ApplicationController
  require 'openssl'

  def handshake
    @membership = Membership.new
    encrypted_and_encoded = Base64.encode64(params[:secret_data]).encode('utf-8')
    session[:secret_data] = encrypted_and_encoded
  end

  def handshake_retake
    @membership = Membership.new
  end

  def create
    correct_organization = Organization.find_by_code(params[:membership][:organization_id])
    if correct_organization
      user_id = Membership.decode_user_id(params)
      @person = Person.find(user_id)
      @membership = Membership.find_by_person_id(user_id) || Membership.new
      @membership.person_id = user_id
      @membership.organization_id = correct_organization.id
      if @membership.save
        redirect_to people_url, notice: "Thanks for connecting to CW Dash, #{@person.first_name}!"
      else
        redirect_to(handshake_retake_path)
      end
    else
      redirect_to(handshake_retake_path)
    end
  end

  def update
    correct_organization = Organization.find_by_code(params[:membership][:organization_id])
    if correct_organization
      user_id = Membership.decode_user_id(params)

      @person = Person.find(user_id)
      @membership = Membership.find_by_person_id(user_id) || Membership.new
      @membership.person_id = user_id
      @membership.organization_id = correct_organization.id
      if @membership.save
        redirect_to people_url, notice: "Thanks for connecting to CW Dash, #{@person.first_name}!"
      else
        redirect_to(handshake_retake_path)
      end
    else
      redirect_to(handshake_retake_path)
    end
  end

end
