require 'spec_helper'

describe OrganizationsController do

  render_views

  before :each do
    @organization = create(:organization)
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
        get :show, id: @organization
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'GET #new' do
      it "requires login" do
        get :new
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'GET #edit' do
      it "requires login" do
        get :edit, id: @organization
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'POST #create' do
      it "requires login" do
        post :create
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'PUT #update' do
      it "requires login" do
        put :update, id: @organization
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: @organization
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

    describe 'GET #show' do
      it "requires omron" do
        get :show, id: @organization
        expect(response).to redirect_to people_url
      end
    end

    describe 'GET #new' do
      it "requires omron" do
        get :new
        expect(response).to redirect_to people_url
      end
    end

    describe 'GET #edit' do
      it "requires omron" do
        get :edit, id: @organization
        expect(response).to redirect_to people_url
      end
    end

    describe 'POST #create' do
      it "requires omron" do
        post :create
        expect(response).to redirect_to people_url
      end
    end

    describe 'PUT #update' do
      it "requires omron" do
        put :update, id: @organization
        expect(response).to redirect_to people_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires omron" do
        delete :destroy, id: @organization
        expect(response).to redirect_to people_url
      end
    end
  end


  context 'omron user' do
    before :each do
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

    describe 'GET #show' do
      it 'assigns organization to @organization' do
        get :show, id: @organization
        expect(assigns(:organization)).to eq(@organization)
      end
      it 'renders the :show template' do
        get :show, id: @organization
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'assigns a new Organization to @organization' do
        get :new
        expect(assigns(:organization)).to be_a_new(Organization)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'assigns the correct organization to @organization' do
        get :edit, id: @organization
        expect(assigns(:organization)).to eq(@organization)
      end
      it 'renders the :edit template' do
        get :edit, id: @organization
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      it 'creates a new Organization' do
        expect{
          post :create, organization: attributes_for(:organization)
        }.to change(Organization, :count).by(1)
      end
      it 'redirects to the new organization page' do
        post :create, organization: attributes_for(:organization)
        expect(response).to redirect_to Organization.last
      end
    end

    describe 'PUT #update' do
      it "identifies the correct organization" do
        put :update, id: @organization, organization: attributes_for(:organization, name: "NewCo")
        expect(assigns(:organization)).to eq(@organization)
      end
      it "updates the organization's attributes" do
        put :update, id: @organization, organization: attributes_for(:organization, name: "NewCo")
        @organization.reload
        expect(@organization.name).to eq("NewCo")
      end
      it "redirects to the organization's page" do
        put :update, id: @organization, organization: attributes_for(:organization, name: "NewCo")
        expect(response).to redirect_to @organization
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the organization" do
        expect{
          delete :destroy, id: @organization
        }.to change(Organization, :count).by(-1)
      end
      it "redirects to the organization index" do
        delete :destroy, id: @organization
        expect(response).to redirect_to organizations_url
      end
    end
  end

end
