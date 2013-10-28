 class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron_business
  before_action :check_and_create_person_quarters, only: [:retention]

  include PiratesHelper

  def activations
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end
    @discrete_month_activations = discrete_month_activations(@year)
    @aggregate_month_activations = aggregate_month_activations(@discrete_month_activations, @year)
    @y_values_as_json = @aggregate_month_activations.to_json
  end

  def devices
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end

    @q1_start = "#{@year}-01-01".to_date
    @q2_start = "#{@year}-04-01".to_date
    @q3_start = "#{@year}-07-01".to_date
    @q4_start = "#{@year}-10-01".to_date

    if @year == Time.now.year
      current_month = Time.now.month

      quarter_hash = { 1 => @q1_start, 2 => @q1_start, 3 => @q1_start, 4 => @q2_start, 5 => @q2_start, 6 => @q2_start, 7 => @q3_start, 8 => @q3_start, 9 => @q3_start, 10 => @q4_start, 11 => @q4_start, 12 => @q4_start }

      current_quarter = quarter_hash[current_month]

      if current_quarter == "#{@year}-01-01".to_date
        @Q1HJ720 = current_quarter_activations("HJ-720", current_quarter)
        @Q1HJA312 = current_quarter_activations("HJA-312", current_quarter)
        @Q1HJ322 = current_quarter_activations("HJ-322", current_quarter)
        @Q2HJ720 = "-"
        @Q2HJA312 = "-"
        @Q2HJ322 = "-"
        @Q3HJ720 = "-"
        @Q3HJA312 = "-"
        @Q3HJ322 = "-"
        @Q4HJ720 = "-"
        @Q4HJA312 = "-"
        @Q4HJ322 = "-"
      elsif current_quarter == "#{@year}-04-01".to_date
        @Q1HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q1_start).first.activations
        @Q1HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q1_start).first.activations
        @Q1HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q1_start).first.activations
        @Q2HJ720 = current_quarter_activations("HJ-720", current_quarter)
        @Q2HJA312 = current_quarter_activations("HJA-312", current_quarter)
        @Q2HJ322 = current_quarter_activations("HJ-322", current_quarter)
        @Q3HJ720 = "-"
        @Q3HJA312 = "-"
        @Q3HJ322 = "-"
        @Q4HJ720 = "-"
        @Q4HJA312 = "-"
        @Q4HJ322 = "-"
      elsif current_quarter == "#{@year}-07-01".to_date
        @Q1HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q1_start).first.activations
        @Q1HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q1_start).first.activations
        @Q1HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q1_start).first.activations
        @Q2HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q2_start).first.activations
        @Q2HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q2_start).first.activations
        @Q2HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q2_start).first.activations
        @Q3HJ720 = current_quarter_activations("HJ-720", current_quarter)
        @Q3HJA312 = current_quarter_activations("HJA-312", current_quarter)
        @Q3HJ322 = current_quarter_activations("HJ-322", current_quarter)
        @Q4HJ720 = "-"
        @Q4HJA312 = "-"
        @Q4HJ322 = "-"
      elsif current_quarter == "#{@year}-10-01".to_date
        @Q1HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q1_start).first.activations
        @Q1HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q1_start).first.activations
        @Q1HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q1_start).first.activations
        @Q2HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q2_start).first.activations
        @Q2HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q2_start).first.activations
        @Q2HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q2_start).first.activations
        @Q3HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q3_start).first.activations
        @Q3HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q3_start).first.activations
        @Q3HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q3_start).first.activations
        @Q4HJ720 = current_quarter_activations("HJ-720", current_quarter)
        @Q4HJA312 = current_quarter_activations("HJA-312", current_quarter)
        @Q4HJ322 = current_quarter_activations("HJ-322", current_quarter)
      end
    else
      @Q1HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q1_start).first.activations
      @Q2HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q2_start).first.activations
      @Q3HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q3_start).first.activations
      @Q4HJ720 = DeviceQuarter.where(device_model: "HJ-720").where(start_date: @q4_start).first.activations

      @Q1HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q1_start).first.activations
      @Q2HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q2_start).first.activations
      @Q3HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q3_start).first.activations
      @Q4HJA312 = DeviceQuarter.where(device_model: "HJA-312").where(start_date: @q4_start).first.activations

      @Q1HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q1_start).first.activations
      @Q2HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q2_start).first.activations
      @Q3HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q3_start).first.activations
      @Q4HJ322 = DeviceQuarter.where(device_model: "HJ-322").where(start_date: @q4_start).first.activations
    end

  end

  def retention
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end
  end

  def users_lost
    @start_date = params[:quarter]
    @person_quarters = PersonQuarter.users_lost(@start_date)
  end


  private

  def check_and_create_person_quarters
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end

    @q1_start = "#{@year}-01-01".to_date
    @q2_start = "#{@year}-04-01".to_date
    @q3_start = "#{@year}-07-01".to_date
    @q4_start = "#{@year}-10-01".to_date

    if @year == Time.now.year
      current_month = Time.now.month

      quarter_hash = { 1 => @q1_start, 2 => @q1_start, 3 => @q1_start, 4 => @q2_start, 5 => @q2_start, 6 => @q2_start, 7 => @q3_start, 8 => @q3_start, 9 => @q3_start, 10 => @q4_start, 11 => @q4_start, 12 => @q4_start }

      current_quarter = quarter_hash[current_month]
      previous_quarter = current_quarter - 3.months

      unless PersonQuarter.where(start_date: previous_quarter).present?

        # create PQ records for everyone who has uploaded at all
        all_users_who_have_uploaded = Upload.select("distinct user_id")
        all_users_who_have_uploaded.each do |row|
          pq = PersonQuarter.new
          pq.person_id = row.user_id
          pq.active = false
          pq.start_date = previous_quarter

          # set the "previous quarter" boolean -- note: relative to Time.now, this is referring to TWO quarters ago
          two_quarters_ago_start_date = previous_quarter - 3.months
          previous_person_quarter = PersonQuarter.where(person_id: row.user_id).where(start_date: two_quarters_ago_start_date).first
          if previous_person_quarter
            if previous_person_quarter.active == false
              pq.previous_quarter = false
            else
              pq.previous_quarter = true
            end
          else
            pq.previous_quarter = false
          end

          pq.save
        end

        # edit the PQs for users who were active (15+ uploads) during the previous quarter
        active_users_in_previous_quarter = Upload.find_by_sql(["select user_id, count(*) from of_of_measurements where date >= ? and date < ? group by user_id having count(*) > 14", previous_quarter, current_quarter])
        active_users_in_previous_quarter.each do |row|
          q = PersonQuarter.where("person_id = ? and start_date = ?", row.user_id, previous_quarter).first
          q.active = true
          q.save
        end
      end
    end
  end

end
