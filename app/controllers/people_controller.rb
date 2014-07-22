class PeopleController < ApplicationController
  before_action :require_signin
  before_action :protect_show, only: [:show]

  def export_to_csv
    csv_string = CSV.generate do |csv|
      csv << ["Name", "Upload Date", "Steps", "Aerobic Steps", "Calories", "Miles", "Device Serial", "Input Method"]
      unless admin
        Organization.find(current_client.organization.id).uploads.includes(:person).find_in_batches(batch_size: 4600) do |group|
          group.each do |upload|
            if upload.is_device_input == 1
              input_method = "Synced from Device"
            else
              input_method = "Manually Uploaded"
            end
            csv << ["#{upload.person.first_name} #{upload.person.last_name}", upload.date.try(:strftime, "%b %d, %Y"), upload.total_steps, upload.aerobic_steps, upload.calories, ('%.2f' % upload.distance), upload.device_serial, input_method]
          end
        end
      end
      if admin && params[:organization_id]
        Organization.find(params[:organization_id]).uploads.includes(:person).find_in_batches(batch_size: 4600) do |group|
          group.each do |upload|
            if upload.is_device_input == 1
              input_method = "Synced from Device"
            else
              input_method = "Manually Uploaded"
            end
            csv << ["#{upload.person.first_name} #{upload.person.last_name}", upload.date.try(:strftime, "%b %d, %Y"), upload.total_steps, upload.aerobic_steps, upload.calories, ('%.2f' % upload.distance), upload.device_serial, input_method]
          end
        end
      elsif admin
        Organization.all.uploads.includes(:person).find_in_batches(batch_size: 4600) do |group|
          group.each do |upload|
            if upload.is_device_input == 1
              input_method = "Synced from Device"
            else
              input_method = "Manually Uploaded"
            end
            csv << ["#{upload.person.first_name} #{upload.person.last_name}", upload.date.try(:strftime, "%b %d, %Y"), upload.total_steps, upload.aerobic_steps, upload.calories, ('%.2f' % upload.distance), upload.device_serial, input_method]
          end
        end
      end
    end

    send_data csv_string,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=test.csv"
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
    if @first_upload_date == nil
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
