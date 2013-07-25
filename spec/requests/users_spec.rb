require 'spec_helper'

describe "Users" do

  context "who are regular users" do
    before(:each) do
      @user = create(:user)
      @coworker = create(:person, organization: @user.organization)
      @rival = create(:person)
      visit root_url
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Sign in"
    end

    context "logging in" do
      it "should log in successfully" do
        page { should have_link "Sign out" }
      end

      it "should be immediately routed to the people index" do
        page.should have_content("People")
      end

      it "should only see people from their organization" do
        page.should have_content(@coworker.email)
        page.should_not have_content(@rival.email)
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

      it "can only search people from within their organization" do

      end

      it "can visit their coworkers' show pages" do
        visit person_url(@coworker)
        page.should have_content(@coworker.first_name)
      end

      it "should not be able to access a rival's show page" do
        visit person_url(@rival)
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
        person1 = create(:person)
        person2 = create(:person)
        click_link "All People"
        page.should have_content(person1.organization.name)
        page.should have_content(person2.organization.name)
      end
    end
  end # end context "who are omron users"

end
