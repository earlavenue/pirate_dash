class ClientsController < ApplicationController
  before_action :require_signin
  before_action :require_omron

  def index
    @clients = Client.includes(:organization).order("organizations.name")
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def edit
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
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

  def client_params
    params.require(:client).permit(:email, :password_digest, :password, :password_confirmation, :first_name, :last_name, :organization_id)
  end
end
