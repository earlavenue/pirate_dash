require 'spec_helper'

describe Client do
  context "that exists" do
    before :each do
      @client = create(:client, first_name: "batman", password: "gotham", password_confirmation: "gotham")
    end

    it "authenticates with matching clientname and password" do
      expect(@client.authenticate("gotham")).to be_valid
    end

    it "does not authenticate with incorrect password" do
      expect(@client.authenticate("metropolis")).to be_false
    end
  end

  it "has a unique email address" do
    create(:client, email: "duke@ellington.com")
    client = build(:client, email: "duke@ellington.com")
    expect(client).to have(1).errors_on(:email)
  end

  it "must have an email address" do
    client = build(:client, email: nil)
    expect(client).to have(1).errors_on(:email)
  end

  it { should belong_to(:organization) }
  it { should validate_uniqueness_of(:email) }
end
