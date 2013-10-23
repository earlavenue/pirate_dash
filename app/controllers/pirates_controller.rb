 class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron_business

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
  end

end


    # @quarter_count_for_HJ72 = quarter_count_for_device(@year, "HJ-720")
    # @device_HJ72 = ['HJ-720IT', @quarter_count_for_HJ72]

    # @quarter_count_for_HJA = quarter_count_for_device(@year, "HJA-312")
    # @device_HJA = ['HJA-312', @quarter_count_for_HJA]

    # @quarter_count_for_HJ322 = quarter_count_for_device(@year, "HJ-322")
    # @device_HJ322 = ['HJ-322', @quarter_count_for_HJ322]

    # @quarter_count_for_HJ323 = quarter_count_for_device(@year, "HJ-323")
    # @device_HJ323 = ['HJ-323', @quarter_count_for_HJ323]

    # @device_HJ320s = ['HJ-320s', @quarter_count_for_HJ322 + @quarter_count_for_HJ323]

    # @devices = [@device_HJ72, @device_HJA, @device_HJ320s]
    # @month_count_for_device_002 = montht_count_for_device(2013, "002")
    # @quarterly_values_002 = quarterly_device_values(@month_count_for_device_002)
    # @device_002 = ['HJ-322, 323, 324', @quarterly_values_002]

