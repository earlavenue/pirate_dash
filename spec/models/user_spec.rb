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

  # context "that is an Omron Fitness user" do
  #   it "can visit the Organizations page" do
  #     @current_user = build(:omron_user)
  #     session[:user_id] = @current_user.id
  #     get organizations_url
  #     response.code.should eq("200")
  #   end
  # end

  # context "that is NOT an Omron Fitness user" do
  #   it "cannot visit the Organizations page" do
  #     get organizations_path
  #     response.code.should eq("302")
  #   end
  # end

end
