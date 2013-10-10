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
    @quarter_count_for_HJ72 = quarter_count_for_device(@year, "HJ72")
    @device_HJ72 = ['HJ-720IT', @quarter_count_for_HJ72]

    @quarter_count_for_HJA = quarter_count_for_device(@year, "HJA")
    @device_HJA = ['HJA-312', @quarter_count_for_HJA]

    @quarter_count_for_0002 = quarter_count_for_device(@year, "0002")
    @device_0002 = ['HJ-322, 323, 324', @quarter_count_for_0002]

    @devices = [@device_HJ72, @device_HJA, @device_0002]
    # @month_count_for_device_002 = montht_count_for_device(2013, "002")
    # @quarterly_values_002 = quarterly_device_values(@month_count_for_device_002)
    # @device_002 = ['HJ-322, 323, 324', @quarterly_values_002]
  end
end
