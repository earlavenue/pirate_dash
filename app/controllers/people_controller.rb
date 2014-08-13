class PeopleController < ApplicationController
  before_action :require_signin
  before_action :protect_show, only: [:show]

  def export_to_csv
    if admin && params[:organization_id]
      if ClientMailer.delay.send_csv(params[:organization_id], current_client.id)
        redirect_to people_path(omron_click: params[:organization_id]), notice: "An email with your organization's uploads will arrive shortly"
      else
        redirect_to people_path(omron_click: params[:organization_id]), notice: "We're sorry something went wrong."
      end
    else
      if ClientMailer.send_csv(Organization.find(current_client.organization.id), current_client.id).deliver
        redirect_to people_path, notice: "An email with your organization's uploads will arrive shortly"
      else
        redirect_to people_path, notice: "We're sorry something went wrong."
      end
    end
  end
  def export_csv_2_months
    if admin && params[:organization_id]
      send_data Organization.find(params[:organization_id]).export_2_months,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{Organization.find(params[:organization_id]).name}.csv"
    else
      send_data Organization.find(current_client.organization.id).export_2_months,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{Organization.find(current_client.organization.id).name}.csv"
    end
  end

  def index
    if admin
      @organization_id = params[:omron_click]
      @people = Person.admin_index_view.order_by_organization.page(params[:page])
      if params[:omron_click].present?
        @people = @people.from_organization(params[:omron_click])
      elsif params[:search_last_name].present?
        @people = @people.with_last_name(params[:search_last_name])
      end
    else
      @people = Person.client_index_view.from_organization(current_client.organization_id).page(params[:page])
      if params[:search_last_name].present?
        @people = @people.with_last_name(params[:search_last_name])
      end
    end

    respond_to do |format|
      format.js
      format.html
      # format.csv { send_data @people.to_csv}
    end
  end

  def show
    if params[:date].blank?
      @date = Time.zone.now.to_date
    else
      @date = params[:date].to_date
    end
    @person = Person.show_page_columns.find(params[:id])
    @uploads = Upload.show_page_columns.belonging_to_person(@person).within_date_range(@date.beginning_of_month, @date.end_of_month + 1.day).order("date ASC") || []
    @month_stats_hash = Upload.month_stats(@uploads)
    if @person.membership.first_upload_date == "0000-00-00" || @person.membership.first_upload_date == nil
      @first_upload_date = Membership.set_first_upload_date(@person)
    else
      @first_upload_date = @person.membership.first_upload_date
    end
    if @first_upload_date == nil && @person.uploads == []
      redirect_to people_url, notice: "There is no upload data for this person."
    end
  end

  private

  def protect_show
    @person = Person.find_by_user_id(params[:id])
    unless admin || current_client.organization.name == @person.organization.name
      redirect_to people_url, :notice => "You are not authorized to view that person"
    end
  end


end
