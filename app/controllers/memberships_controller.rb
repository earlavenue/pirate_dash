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
      encrypted_and_encoded = params[:membership][:person_id]
      decoded = Base64.decode64 encrypted_and_encoded.encode('ascii-8bit')

      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = "x04xD4xA7xB4sTx12xF3x1Ax9DxD1xC9xA0Hx9Ex86x1Cf1x05VMnxDFMxA3xA9ixDCsxA6"
      decipher.iv = "x11x8Dx02x1A[xCA'xF9xE8.JxADbx06x95x02"

      user_id = decipher.update(decoded) + decipher.final

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
      encrypted_and_encoded = params[:membership][:person_id]
      decoded = Base64.decode64 encrypted_and_encoded.encode('ascii-8bit')

      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = "x04xD4xA7xB4sTx12xF3x1Ax9DxD1xC9xA0Hx9Ex86x1Cf1x05VMnxDFMxA3xA9ixDCsxA6"
      decipher.iv = "x11x8Dx02x1A[xCA'xF9xE8.JxADbx06x95x02"

      user_id = decipher.update(decoded) + decipher.final

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
