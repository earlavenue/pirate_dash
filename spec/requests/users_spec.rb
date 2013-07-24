require 'spec_helper'

describe "Users" do

  # it "test factory" do
  #   omron_user = create(:omron_user)
  #   omron_user.organization.name.should eq("Omron Fitness")
  # end

  context "logging in" do
    it "should log you in" do
      user = create(:user)
      visit root_url
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      page { should have_link "Sign out" }
    end

    context "as regular user" do
      it "should go to the people index" do
        user = create(:user)
        visit root_url
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        page.should have_content("People")
      end
    end

    context "as omron user" do
      it "should go to the organizations index" do
        user = create(:omron_user)
        visit root_url
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
        page.should have_content("organizations")
      end
    end
  end
end
