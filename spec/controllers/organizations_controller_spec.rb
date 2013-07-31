require 'spec_helper'

describe OrganizationsController do

  context 'guest visitor' do
    before :each do
      @organization = create(:organization)
    end

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

  # context 'regular user' do
  #   before :each do
  #     user = create(:user)
  #     session[:user_id] = user.id
  #   end

  #   describe 'GET #index' do
  #     it "requires omron" do
  #       get :index
  #       expect(response).to redirect_to people_url
  #     end
  #   end

  #   describe 'GET #show' do
  #     it "requires omron" do
  #       get :show, id: @organization
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  #   describe 'GET #new' do
  #     it "requires omron" do
  #       get :new
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  #   describe 'GET #edit' do
  #     it "requires omron" do
  #       get :edit, id: @organization
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  #   describe 'POST #create' do
  #     it "requires omron" do
  #       post :create
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  #   describe 'PUT #update' do
  #     it "requires omron" do
  #       put :update, id: @organization
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  #   describe 'DELETE #destroy' do
  #     it "requires omron" do
  #       delete :destroy, id: @organization
  #       expect(response).to redirect_to people_url
  #     end
  #   end
  # end

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

    describe 'GET #show' do
      it 'assigns organization to @organization' do
        get :show, id: @organization
        expect(assigns(:organization)).to eq @organization
      end
    end


  end

end
