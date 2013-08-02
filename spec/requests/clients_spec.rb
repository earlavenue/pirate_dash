=begin
require 'spec_helper'

describe "Clients" do

  context "who are regular clients" do
    before(:each) do
      @client = create(:client)
      @coworker = create(:person, organization: @client.organization)
      @rival = create(:person)
      visit root_url
      fill_in "Email", with: @client.email
      fill_in "Password", with: @client.password
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

      it "should not be able to access the clients page" do
        visit clients_url
        page.should have_content("not authorized")
      end

      it "can only search people from within their organization" do
        # WILL
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
  end # end context "who are regular clients"

  context "who are omron clients" do
    before(:each) do
      client = create(:omron_client)
      visit root_url
      fill_in "Email", with: client.email
      fill_in "Password", with: client.password
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
      it "can access the clients page" do
        click_link "Clients"
        page.should have_content("clients")
      end

      it "can see people from all organizations" do
        person1 = create(:person)
        person2 = create(:person)
        click_link "All People"
        page.should have_content(person1.organization.name)
        page.should have_content(person2.organization.name)
      end
    end
  end # end context "who are omron clients"

end
=end
