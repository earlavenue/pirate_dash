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
    @quarter_count_for_HJ72 = quarter_count_for_device(@year, "HJ-720")
    @device_HJ72 = ['HJ-720IT', @quarter_count_for_HJ72]

    @quarter_count_for_HJA = quarter_count_for_device(@year, "HJA-312")
    @device_HJA = ['HJA-312', @quarter_count_for_HJA]

    @quarter_count_for_HJ322 = quarter_count_for_device(@year, "HJ-322")
    @device_HJ322 = ['HJ-322', @quarter_count_for_HJ322]

    @quarter_count_for_HJ323 = quarter_count_for_device(@year, "HJ-323")
    @device_HJ323 = ['HJ-323', @quarter_count_for_HJ323]

    @device_HJ320s = ['HJ-320s', @quarter_count_for_HJ322 + @quarter_count_for_HJ323]

    @devices = [@device_HJ72, @device_HJA, @device_HJ320s]
    # @month_count_for_device_002 = montht_count_for_device(2013, "002")
    # @quarterly_values_002 = quarterly_device_values(@month_count_for_device_002)
    # @device_002 = ['HJ-322, 323, 324', @quarterly_values_002]
  end
  def retention
  end
end
