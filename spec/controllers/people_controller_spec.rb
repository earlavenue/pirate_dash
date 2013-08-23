require 'spec_helper'

describe PeopleController do

  render_views

  before :each do
    @organization_good = create(:organization, name: "GoodVille")
    @organization_evil = create(:organization, name: "EvilCity")
    @person_good = create(:person, first_name: "Good", last_name: "Lolly", organization: @organization_good)
    @person_good2 = create(:person, organization: @organization_good)
    @person_evil = create(:person, first_name: "Evil", last_name: "Lolly", organization: @organization_evil)
    @person_evil2 = create(:person, organization: @organization_evil)
  end

  context 'guest visitor' do

    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'GET #show' do
      it "requires login" do
        get :show, id: @person_good
        expect(response).to redirect_to new_session_url
      end
    end
  end

  context 'regular client' do
    before :each do
      client = create(:client, organization: @organization_good)
      session[:client_id] = client.id
    end

    describe 'GET #index' do
      it "shows all people from current_client's organization" do
        get :index
        expect(assigns(:people)).to match_array [@person_good, @person_good2]
      end
      it "doesn't show people from other_client's organizations" do
        get :index
        expect(assigns(:people)).to_not include(@evil_person)
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end

      #COME BACK TO THIS SEARCH
      # it "renders only a person with the correct last name on a search" do
      #   visit people_url
      #   fill_in "search-query", with: "Lolly"
      #   click_button "Search"
      #   page.should have_content "Good"
      # end
    end

    describe 'GET #show' do
      it "doesn't allow through a client if client and person don't have the same organization" do
        get :show, id: @person_evil
        expect(response).to redirect_to people_url
      end
    end
  end
end