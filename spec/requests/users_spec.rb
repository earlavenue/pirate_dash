require 'spec_helper'

describe "Users" do

  context "who are regular users" do
    before(:each) do
      user = create(:user)
      visit root_url
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
    context "logging in" do
      it "should log in successfully" do
        page { should have_link "Sign out" }
      end

      it "should be immediately routed to the people index" do
        page.should have_content("People")
      end
    end

    context "navigating the site" do
      it "should not be able to access the organizations page" do
        visit organizations_url
        page.should have_content("not authorized")
      end

      it "should not be able to access the users page" do
        visit users_url
        page.should have_content("not authorized")
      end
    end
  end # end context "who are regular users"

  context "who are omron users" do
    before(:each) do
      user = create(:omron_user)
      visit root_url
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end

    context "logging in" do
      it "should log in successfully" do
        page { should have_link "Sign out" }
      end

      it "should be immediately routed to the organizations index" do
        page.should have_content("organizations")
      end
    end

    context "navigating the site" do
      it "can access the users page" do
        click_link "Users"
        page.should have_content("users")
      end

      it "can see people from all organizations" do
        org1 = build(:organization)
        person1 = build(:person)
        org2 = build(:organization)
        person2 = build(:person)
        click_link "All people"
        page.should have_content(org1.name)
        page.should have_content(org2.name)
      end
    end
  end # end context "who are omron users"

end
