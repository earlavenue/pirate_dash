class ClientsController < ApplicationController
  before_action :require_signin
  before_action :require_omron, :except => [:show, :edit_profile, :edit_password, :update_profile, :update_password]
  before_action :authenticate_client, :only => [:show, :edit_profile, :edit_password, :update_profile, :update_password]

  def index
    @clients = Client.includes(:organization).order("organizations.name")
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def edit # Admin Edit
    @client = Client.find(params[:id])
  end

  def edit_profile # Regular Client
    @client = Client.find(params[:id])
  end

  def edit_password # Regular Client
    @client = Client.find(params[:id])
  end

  def update_profile
    @client = Client.find(params[:id])
    if @client.update_attributes(edit_profile_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render action: "edit_profile"
    end
  end

  def update_password
    @client = Client.find(params[:id])
    if @client.authenticate(params[:client][:current_password])
      if @client.update_attributes(edit_password_params)
        redirect_to @client, notice: 'Client was successfully updated.'
      else
        render action: "edit_password"
      end
    else
      @client.errors[:base] << "Incorrect Current Password"
      render action: "edit_password"
    end
  end

  def create
    @client = Client.new(full_client_params)
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(full_client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url
  end

  private

  def authenticate_client

    if current_client != Client.find(params[:id]) && current_client.organization != Organization.find_by_name("Omron Fitness")
      redirect_to client_path(current_client), notice: "You are not authorized to view this page."
    end
  end

  def edit_profile_params
    params.require(:client).permit(:first_name, :last_name, :email)
  end

  def edit_password_params
    params.require(:client).permit(:password, :password_confirmation)
  end

  def full_client_params
    params.require(:client).permit(:email, :password_digest, :password, :password_confirmation, :first_name, :last_name, :organization_id)
  end
end
