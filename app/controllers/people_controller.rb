class PeopleController < ApplicationController
  before_filter :require_signin

  before_filter :require_omron, only: [:edit, :update, :destroy]

  before_filter :protect_show, only: [:show]


  def protect_show
    @person = Person.find_by_id(params[:id])
    if current_user.organization.name != "Omron Fitness" && current_user.organization.name != @person.organization.name
      redirect_to people_url, :notice => "You cannot view that person"
    end
  end

  def operations
  end

  def sync
    Person.sync
    redirect_to people_url, notice: 'People successfully synced.'
  end

  def import #importing people
    Person.import(params[:file], params[:person][:organization_id])
    redirect_to people_url
  end

  def import_uploads
    Upload.import(params[:file])
    redirect_to people_url
  end


#First we check if someone is Omron. If they are we check if they got to this page from the organizations index (:omron_click). Then we check if they've done a search and give back all results with "last name" or "serial" because the Omron index will have an "organization" column. If the user isn't Omron we check if they've done a search and give back only "last names" etc. at the user's company.
  def index
    if current_user.organization.name == "Omron Fitness"
      if params[:omron_click].present?
        @people = Person.where(organization_id: params[:omron_click])
      elsif params[:search_last_name].present?
        @people = Person.search_last_name_results(params[:search_last_name])
      elsif params[:search_serial].present?
        @people = Person.search_serial_results(params[:search_serial])
      else
        @people = Person.all
      end
    else
      if params[:search_last_name].present?
        @people = Person.search_last_name_results(params[:search_last_name]).where(organization_id: current_user.organization_id)
      elsif params[:search_serial].present?
        @people = Person.search_serial_results(params[:search_serial]).where(organization_id: current_user.organization_id)
      else
        @people = Person.where(organization_id: current_user.organization.id)
      end
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_url
  end
end
