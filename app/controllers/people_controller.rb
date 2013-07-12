class PeopleController < ApplicationController
  before_filter :require_signin

  def operations
  end

  def sync
    Person.sync
    redirect_to people_url, notice: 'People successfully synced.'
  end

  def import #importing people
    Person.import(params[:file], current_user.organization.id)
    redirect_to people_url
  end

  def import_uploads
    Upload.import(params[:file])
    redirect_to people_url
  end

  def index
    if params[:search_last_name].present?
      @people = Person.search_last_name_results(params[:search_last_name])
    elsif params[:search_serial].present?
      @people = Person.search_serial_results(params[:search_serial])
    else
      if current_user.organization.name == "omron"
        if params[:omron_click].present?
          @people = Person.where(organization_id: params[:omron_click])
        else
          @people = Person.all
        end
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
