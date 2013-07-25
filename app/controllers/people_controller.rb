class PeopleController < ApplicationController
  before_filter :require_signin

  before_filter :require_omron, only: [:edit, :update, :destroy, :operations, :import, :import_uploads]

  before_filter :protect_show, only: [:show]
  before_filter :has_no_data, only: [:show]


  def protect_show
    @person = Person.find_by_id(params[:id])
    if current_user.organization.name != "Omron Fitness" && current_user.organization.name != @person.organization.name
      redirect_to people_url, :notice => "You are not authorized to view that person"
    end
  end

  def has_no_data
    @person = Person.find_by_id(params[:id])
    if @person.uploads.blank?
      redirect_to people_url, :notice => "There is no data for this person"
    end
  end

  def operations
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
    # @people = Person.joins(:organization).order("organizations.name").all
    # @people = @people.with_last_name(params[:search_last_name]) if params[:search_last_name].present?

    if current_user.organization.name == "Omron Fitness"
      if params[:omron_click].present?
        @people = Person.where(organization_id: params[:omron_click])
      elsif params[:search_last_name].present?
        @people = Person.search_last_name_results(params[:search_last_name]).joins(:organization).order("organizations.name")
      elsif params[:search_serial].present?
        @people = Person.search_serial_results(params[:search_serial]).joins(:organization).order("organizations.name")
      else
        @people = Person.joins(:organization).order("organizations.name").all
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

    respond_to do |format|
      format.js
      format.html
    end

  end

  def show
    @person = Person.find(params[:id])
    @person_uploads = @person.uploads
    if params[:date].blank?
      @date = @person_uploads.first.upload_time
    else
      @date = params[:date].to_date
    end
    @month_stats_hash = @person.month_stats(@person_uploads, @date)
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
