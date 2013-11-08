class PeopleController < ApplicationController
  before_action :require_signin
  before_action :protect_show, only: [:show]

  def export_to_csv
    if admin && params[:organization_id]
      people = Person.from_organization(params[:organization_id])
    elsif admin
      people = Person.all
    else
      people = Person.from_organization(current_client.organization.id)
    end

    # query = <<-END
    #   select person.first_name, person.last_name, upload.date, upload.total_steps, upload.aerobic_steps, upload.calories, upload.distance, upload.device_serial, upload.is_device_input

    #   from of_of_measurements as upload

    #   inner join of_of_users as person
    #   on upload.user_id = person.user_id

    #   inner join memberships
    #   on person.user_id = memberships.person_id

    #   inner join organizations
    #   on memberships.organization_id = organizations.id

    #   where memberships.organization_id = ?

    # END

    csv_string = CSV.generate do |csv|
      csv << ["Name", "Upload Date", "Steps", "Aerobic Steps", "Calories", "Miles", "Device Serial", "Input Method"]
      people_with_uploads = people.includes(:uploads)
      people_with_uploads.each do |p|
        p.uploads.each do |u|
          if u.is_device_input == 1
            input_method = "Synced from Device"
          else
            input_method = "Manually Uploaded"
          end
          csv << [p.first_name, p.last_name, u.date.try(:strftime, "%b %d, %Y"), u.total_steps, u.aerobic_steps, u.calories, ('%.2f' % u.distance), u.device_serial, input_method]
        end
      end
    end

    # result_set = Person.joins("uploads on uploads.user_id = person.user_id").joins("memberships on person.user_id = membership.person_id").joins("organizations on memberships.organization_id = organizations.id").select("people.first_name, people.last_name, uploads.date, uploads.total_steps, uploads.aerobic_steps, uploads.calories, uploads.distance, uploads.device_serial, uploads.is_device_input").where("memberships.organization_id = 7")

    # result_set = Upload.includes(:person).where(organization_id: 7)

    # result_set = Person.find_by_sql([query, 7])
    # debugger

    # csv_string = CSV.generate do |csv|
    #   result_set.each do |row|
    #     csv << row
    #   end
    # end


    # csv_string = CSV.generate do |csv|
    #   csv << ["Name", "Upload Date", "Steps", "Aerobic Steps", "Calories", "Miles", "Device Serial", "Input Method"]
    #   @export_people.each do |person|
    #     person.uploads.each do |upload|
    #       if upload.is_device_input == 1
    #         input_method = "Synced from Device"
    #       else
    #         input_method = "Manually Uploaded"
    #       end
    #       csv << ["#{person.first_name} #{person.last_name}", upload.date.try(:strftime, "%b %d, %Y"), upload.total_steps, upload.aerobic_steps, upload.calories, ('%.2f' % upload.distance), upload.device_serial, input_method]
    #    end
    #   end
    # end


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
