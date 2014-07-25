require 'spec_helper'

describe PeopleController do

  render_views

  before :each do
    @organization_good = create(:organization, name: "GoodVille")
    @organization_evil = create(:organization, name: "EvilCity")

    @person_good = create(:person, first_name: "Good", last_name: "Lolly")
    @membership_good = create(:membership, person_id: @person_good.user_id, organization_id: @organization_good.id)

    @person_good2 = create(:person, last_name: "Pop")
    @membership_good_2 = create(:membership, person_id: @person_good2.user_id, organization_id: @organization_good.id)

    @person_evil = create(:person, first_name: "Evil", last_name: "Lolly")
    @membership_evil = create(:membership, person_id: @person_evil.user_id, organization_id: @organization_evil.id)

    @person_evil2 = create(:person, last_name: "Pop")
    @membership_evil2 = create(:membership, person_id: @person_evil2.user_id, organization_id: @organization_evil.id)
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
      @client = create(:client, organization: @organization_good)
      session[:client_id] = @client.id
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
      it "returns only people with the last name searched in client's organization" do
        get :index, search_last_name: "Lolly"
        expect(assigns(:people)).to match_array [@person_good]
      end
    end

    describe 'GET #show' do
      it 'assigns person to @person' do
        get :show, id: @person_good
        expect(assigns(:person)).to eq(@person_good)
      end
      it "doesn't allow through client if client and person don't have the same organization" do
        get :show, id: @person_evil
        expect(response).to redirect_to people_url
      end

      it "returns a person's show page if the client and person have same organization" do
        get :show, id: @person_good
        expect(response).to render_template :show
      end
    end
  end

  context 'omron client' do
    before :each do
      @omron_client = create(:omron_client)
      session[:client_id] = @omron_client.id
    end

    describe 'GET #index' do
      it "shows all people from all organizations" do
        get :index
        expect(assigns(:people)).to match_array [@person_good, @person_good2, @person_evil, @person_evil2]
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
      it "only renders people from omron_click organization if there is an omron click" do
        get :index, omron_click: @organization_good.id
        expect(assigns(:people)).to match_array [@person_good, @person_good2]
      end
      it "returns all people with the last name searched regardless of organization" do
        get :index, search_last_name: "Lolly"
        expect(assigns(:people)).to match_array [@person_good, @person_evil]
      end
    end
  end
end
