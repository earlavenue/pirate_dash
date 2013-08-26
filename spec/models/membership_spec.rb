require 'spec_helper'

describe Membership do

  context "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:organization) }
  end

  context "validations - shoulda syntax" do
    it { should validate_presence_of(:person_id) }
    it { should validate_presence_of(:organization_id) }
  end

  context "validations - rspec syntax" do
    it "must have a person_id" do
      membership = build(:membership, person_id: nil)
      expect(membership).to have(1).errors_on(:person_id)
    end

    it "must have an organization_id" do
      membership = build(:membership, organization_id: nil)
      expect(membership).to have(1).errors_on(:organization_id)
    end
  end


  it "sets a person's upload date" do
    charlie = create(:person)
    membership = create(:membership, person_id: charlie.id)
    first_upload = create(:upload, person: charlie, date: Time.zone.now - 4.months)
    second_upload = create(:upload, person: charlie, date: Time.zone.now - 2.months)
    expect(Membership.set_first_upload_date(charlie)).to eq((Time.zone.now - 4.months).to_date)
  end

  it "decodes an encrypted and encoded string" do
    require 'openssl'
    string = "Bonjour, mon amie!"
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = "x04xD4xA7xB4sTx12xF3x1Ax9DxD1xC9xA0Hx9Ex86x1Cf1x05VMnxDFMxA3xA9ixDCsxA6"
    cipher.iv = "x11x8Dx02x1A[xCA'xF9xE8.JxADbx06x95x02"

    encrypted_string = cipher.update(string) + cipher.final
    encoded_and_encrypted = Base64.encode64(encrypted_string).encode('utf-8')

    params = {}
    params[:membership] = {}
    params[:membership][:person_id] = encoded_and_encrypted

    expect(Membership.decode_user_id(params)).to eq("Bonjour, mon amie!")
  end

end
