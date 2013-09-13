class OrganizationsController < ApplicationController

  before_action :require_signin
  before_action :require_omron

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      redirect_to @organization, notice: 'Organization was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_url
  end

  private

  def organization_params
    params.require(:organization).permit(:address, :city, :name, :state, :zip, :code)
  end

end
