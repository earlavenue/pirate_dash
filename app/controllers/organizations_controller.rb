class OrganizationsController < ApplicationController

  before_filter :require_signin
  before_filter :require_omron

  def index
    require 'openssl'
    userid = "3663"
    password = "password"

    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    key = cipher.random_key
    @key = key
    iv = cipher.random_iv
    @iv = iv
    @encrypted_data = cipher.update(userid) + cipher.update("|") + cipher.update(password) + cipher.final

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
    @organization = Organization.new(params[:organization])
    if @organization.save
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
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
end
