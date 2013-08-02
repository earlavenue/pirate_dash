class ClientsController < ApplicationController
  before_filter :require_signin

  before_filter :require_omron

  def index
    #when using ":order" remember to use the plural when calling a column on a table. STUPID
    @clients = Client.all(:joins => :organization, :order => "organizations.name")
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
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(params[:client])
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
end
