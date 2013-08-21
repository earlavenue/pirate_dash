class MembershipsController < ApplicationController

  def handshake
    require 'openssl'
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = "x04xD4xA7xB4sTx12xF3x1Ax9DxD1xC9xA0Hx9Ex86x1Cf1x05VMnxDFMxA3xA9ixDCsxA6"
    decipher.iv = "x11x8Dx02x1A[xCA'xF9xE8.JxADbx06x95x02"

    @plain_data = decipher.update(params[:encrypted_data]) + decipher.final
    @user_id = @plain_data.split('|')[0]
    @password = @plain_data.split('|')[1]

    # user_id = user_id_string.to_i

    # decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    # decipher.decrypt
    # decipher.key = params[:key]
    # decipher.iv = params[:iv]
    # @password = decipher.update(params[:encrypted_password]) + decipher.final

    # @person = Person.find(user_id)
    # @membership = Membership.find_by_person_id(user_id) || Membership.new
  end

  def create
    @membership = Membership.new
    @membership.person_id = params[:membership][:person_id]
    @membership.organization_id = params[:membership][:person_id]
    @membership.save
    if @membership.save
      redirect_to people_url, notice: "You've successfully connected to CW Dash!"
    else
      render action: "new"
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.person_id = params[:membership][:person_id]
    @membership.organization_id = params[:membership][:person_id]
    @membership.save
    if @membership.save
      redirect_to people_url, notice: "You've successfully connected to CW Dash!"
    else
      render action: "edit"
    end
  end

end
