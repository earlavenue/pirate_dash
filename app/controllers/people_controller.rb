class PeopleController < ApplicationController
  before_filter :require_signin
  before_filter :require_omron, only: [:edit, :update, :destroy]
  before_filter :protect_show, only: [:show]
  before_filter :has_no_data, only: [:show]

  def index
    if admin
      @people = Person.select("of_of_users.user_id, of_of_users.first_name, of_of_users.last_name, of_of_users.email, organizations.name as organization_name").includes(:uploads).order_by_organization.page(params[:page])
      if params[:omron_click].present?
        @people = @people.from_organization(params[:omron_click])
      elsif params[:search_last_name].present?
        @people = @people.with_last_name(params[:search_last_name])
      end
    else
      @people = Person.from_organization(current_client.organization_id).page(params[:page])
      if params[:search_last_name].present?
        @people = @people.with_last_name(params[:search_last_name])
      end
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  # scope the uploads so that you're only loading that month's uploads, instead of loading ALL uploads every time.
  #WE WILL DO THIS ONCE WE GO TO PRODUCTION. If params[:date] is blank we'll use Time.zone.now
  # @person = Person.includes(:uploads).where("uploads.upload_time BETWEEN ? AND ?", @date.beginning_of_month, @date.end_of_month).find(params[:id]) #make a scope for this
  def show
    @person = Person.includes(:uploads).find(params[:id])
    if params[:date].blank?
      @date = @person.uploads.last.date.to_date
    else
      @date = params[:date].to_date.to_date
    end
    @month_stats_hash = @person.month_stats(@date)
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


  private

  def protect_show
    @person = Person.find_by_user_id(params[:id])
    if current_client.organization.name != "Omron Fitness" && current_client.organization.name != @person.organization.name
      redirect_to people_url, :notice => "You are not authorized to view that person"
    end
  end

  def has_no_data
    @person = Person.find_by_user_id(params[:id])
    if @person.uploads.blank?
      redirect_to people_url, :notice => "There is no data for this person"
    end
  end

end
