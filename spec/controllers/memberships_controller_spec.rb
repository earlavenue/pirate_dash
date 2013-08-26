require 'spec_helper'
require 'openssl'

describe MembershipsController do

  render_views

  describe "GET #handshake" do
    it "assigns a new Membership to @membership" do
      get :handshake, secret_data: rand(36**15).to_s(36)
      expect(assigns(:membership)).to be_a_new(Membership)
    end

    it "renders the :handshake view and form" do
      get :handshake, secret_data: rand(36**15).to_s(36)
      expect(response).to render_template :handshake
    end
  end

  describe "POST #create" do
    before :each do
      @microsoft = create(:organization, name: "Microsoft", code: "windows")
      user_id = 9000
      cipher = OpenSSL::Cipher::AES.new(256, :CBC)
      cipher.encrypt
      @key = cipher.random_key
      @iv = cipher.random_iv
      encrypted_data = cipher.update(user_id) + cipher.final
      @encoded = Base64.encode64(encrypted_data).encode('utf-8')
    end


    it "decrypts the encrypted and encoded string"

    it "identifies a person by the decrypted person_/user_id"

    it "identifies an organization with a correct code"

    it "fails to save with an incorrect code"

    it "redirects to the people_url after a successful membership update"

  end



end
