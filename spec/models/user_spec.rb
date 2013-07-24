require 'spec_helper'

describe User do
  context "that exists" do
    it "authenticates with matching username and password" do
      user = create(:user, first_name: "batman", password: "secret")
      user.authenticate("secret").should be_true#eq(user)
    end

    it "does not authenticate with incorrect password" do
      user = create(:user, first_name: "batman", password: "secret")
      user.authenticate("incorrect").should be_false
    end
  end
end
