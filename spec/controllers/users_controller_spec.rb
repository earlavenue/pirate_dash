require 'spec_helper'

describe UsersController do

  render_views

  before :each do
    @user = create(:user, organization: create(:organization, name: "Zebratown"))
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
        get :show, id: @user
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
        get :edit, id: @user
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
        put :update, id: @user
        expect(response).to redirect_to new_session_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires login" do
        delete :destroy, id: @user
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
        get :show, id: @user
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
        get :edit, id: @user
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
        put :update, id: @user
        expect(response).to redirect_to people_url
      end
    end

    describe 'DELETE #destroy' do
      it "requires omron" do
        delete :destroy, id: @user
        expect(response).to redirect_to people_url
      end
    end
  end


  context 'omron user' do
    before :each do
      @omron_user = create(:omron_user)
      session[:user_id] = @omron_user.id
    end

    describe 'GET #index' do
      it "assigns all users to @users" do
        get :index
        expect(assigns(:users)).to match_array [@user, @omron_user]
      end
      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
      it 'orders the users by organization name' do
        get :index
        expect(assigns(:users)).to start_with(@omron_user)
      end
    end

    describe 'GET #show' do
      it 'assigns user to @user' do
        get :show, id: @user
        expect(assigns(:user)).to eq(@user)
      end
      it 'renders the :show template' do
        get :show, id: @user
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it 'assigns a new user to @user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      it 'assigns the correct user to @user' do
        get :edit, id: @user
        expect(assigns(:user)).to eq(@user)
      end
      it 'renders the :edit template' do
        get :edit, id: @user
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      it 'creates a new user' do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      it 'redirects to the new user page' do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to User.last
      end
    end

    describe 'PUT #update' do
      it "identifies the correct user" do
        put :update, id: @user, user: attributes_for(:user, first_name: "Billy")
        expect(assigns(:user)).to eq(@user)
      end
      it "updates the user's attributes" do
        put :update, id: @user, user: attributes_for(:user, first_name: "Billy")
        @user.reload
        expect(@user.first_name).to eq("Billy")
      end
      it "redirects to the user's page" do
        put :update, id: @user, user: attributes_for(:user, first_name: "Billy")
        expect(response).to redirect_to @user
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the user" do
        expect{
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end
      it "redirects to the user index" do
        delete :destroy, id: @user
        expect(response).to redirect_to users_url
      end
    end
  end

end
