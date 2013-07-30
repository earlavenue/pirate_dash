require 'spec_helper'

describe OrganizationsController do

  context 'guest visitor' do
    describe 'GET #index' do
      it "requires login" do
        get :index
        expect(response).to redirect_to new_session_url
      end
    end
  end

  context 'regular user' do
    before :each do
      user = create(:user)
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      it "requires omron" do
        get :index
        expect(response).to redirect_to people_url
      end
    end
  end

  context 'omron user' do
    before :each do
      @organization = create(:organization)
      omron_user = create(:omron_user)
      session[:user_id] = omron_user.id
      @omron_organization = omron_user.organization
    end

    describe 'GET #index' do
      it "assigns all organizations to @organizations" do
        get :index
        expect(assigns(:organizations)).to match_array [@organization, @omron_organization]
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

end
