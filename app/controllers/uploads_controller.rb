class UploadsController < ApplicationController

  def api
    access_key = params[:access_key]
    start_date = params[:start_date].to_date
    end_date = params[:end_date]|| Time.now.to_date
    end_date = end_date.to_date
    if access_key == "3a388d2b8d83d8070d8be36fbb82271d"
      @uploads = Upload.where("date > ? and date < ?", start_date, end_date)

      respond_to do |format|
        format.json { render json: @uploads }
      end
    else
      redirect_to new_session_path, notice: "Incorrect access key"
    end
  end
end
