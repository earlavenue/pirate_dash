require 'spec_helper'

describe User do
  context "that exists" do
    before :each do
      @user = create(:user, first_name: "batman", password: "gotham")
    end

    it "authenticates with matching username and password" do
      expect(@user.authenticate("gotham")).to be_valid
    end

    it "does not authenticate with incorrect password" do
      expect(@user.authenticate("metropolis")).to be_false
    end
  end

  it "has a unique email address" do
    create(:user, email: "duke@ellington.com")
    user = build(:user, email: "duke@ellington.com")
    expect(user).to have(1).errors_on(:email)
  end
end
