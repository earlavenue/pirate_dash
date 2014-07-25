require 'spec_helper'

describe ClientsController do

  render_views

  before :each do
    @client = create(:client, password: "Corre6t", password_confirmation: "Corre6t", organization: create(:organization, name: "Zebratown"))
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
        get :show, id: @client
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
        get :edit, id: @client
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
        put :update, id: @client
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: @client
        expect(response).to redirect_to new_session_url
      end
    end
  end


  context 'regular client' do
    before :each do
      @client2 = create(:client)
      session[:client_id] = @client2.id
    end

    describe 'GET #index' do
      it "requires omron" do
        get :index
        expect(response).to redirect_to people_url
      end
    end

    describe 'GET #show' do
      it "allows a client to view their show page." do
        get :show, id: @client2
        expect(assigns(:client)).to eq(@client2)
      end
      it "renders the :show template" do
        get :show, id: @client2
        expect(response).to render_template :show
      end

      it "doesn't allow a client to view another client's page" do
        get :show, id: @client
        expect(response).to redirect_to client_url(@client2)
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
        get :edit, id: @client
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
        put :update, id: @client
        expect(response).to redirect_to people_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires omron" do
        delete :destroy, id: @client
        expect(response).to redirect_to people_url
      end
    end

    describe 'GET #edit_profile' do
      it "allows the current client to see their edit page" do
        get :edit_profile, id: @client2
        expect(response).to render_template :edit_profile
      end
      it "doesn't allows the another client to see current client's edit page" do
         get :edit_profile, id: @client
         expect(response).to redirect_to client_url(@client2)
      end
    end

    describe 'GET #edit_password' do
      it "allows the current client to see their edit password page" do
        get :edit_password, id: @client2
        expect(response).to render_template :edit_password
      end
      it "doesn't allows the another client to see current client's edit password page" do
         get :edit_password, id: @client
         expect(response).to redirect_to client_url(@client2)
      end
    end

    describe 'PUT #update_password' do
        it "identifies the correct client" do
          put :update_password, id: @client2, client: attributes_for(:client, password: "New7888", password_confirmation: "New7888")
          expect(assigns(:client)).to eq(@client2)
        end


####Problems with the put request tests

        # it "updates the client's password with correct current password" do
        #   put :update_password, id: @client2, current_password: "Foobar7*", client: attributes_for(:client, password: "New7888", password_confirmation: "New7888")
        #   @client2.reload
        #   expect(@client2.password).to eq("New7888")
        # end

        it "doesn't update the client's attributes with incorrect current password" do
          put :update_password, id: @client, client: attributes_for(:client, current_password: "WRONGO")
          @client.reload
          expect(@client.password).to eq("Corre6t")
        end
      end


  end


  context 'omron client' do
    before :each do
      @omron_client = create(:omron_client)
      session[:client_id] = @omron_client.id
    end

    describe 'GET #index' do
      it "assigns all clients to @clients" do
        get :index
        expect(assigns(:clients)).to match_array [@client, @omron_client]
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
      it 'orders the clients by organization name' do
        get :index
        expect(assigns(:clients)).to start_with(@omron_client)
      end
    end

    describe 'GET #show' do
      it 'assigns client to @client' do
        get :show, id: @client
        expect(assigns(:client)).to eq(@client)
      end
      it 'renders the :show template' do
        get :show, id: @client
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'assigns a new client to @client' do
        get :new
        expect(assigns(:client)).to be_a_new(Client)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'assigns the correct client to @client' do
        get :edit, id: @client
        expect(assigns(:client)).to eq(@client)
      end
      it 'renders the :edit template' do
        get :edit, id: @client
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      it 'creates a new client' do
        expect{
          post :create, client: attributes_for(:client, organization_id: 6)
        }.to change(Client, :count).by(1)
      end
      it 'redirects to the new client page' do
        post :create, client: attributes_for(:client, organization_id: 6)
        expect(response).to redirect_to Client.last
      end
    end

    describe 'PUT #update' do
      it "identifies the correct client" do
        put :update, id: @client, client: attributes_for(:client, first_name: "Billy")
        expect(assigns(:client)).to eq(@client)
      end
      it "updates the client's attributes" do
        put :update, id: @client, client: attributes_for(:client, first_name: "Billy")
        @client.reload
        expect(@client.first_name).to eq("Billy")
      end
      it "redirects to the client's page" do
        put :update, id: @client, client: attributes_for(:client, first_name: "Billy")
        expect(response).to redirect_to @client
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the client" do
        expect{
          delete :destroy, id: @client
        }.to change(Client, :count).by(-1)
      end
      it "redirects to the client index" do
        delete :destroy, id: @client
        expect(response).to redirect_to clients_url
      end
    end
  end

end
