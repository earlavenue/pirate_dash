class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron

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
    @month_count_for_device_HJ72 = month_count_for_device(2013, "HJ72")
    @quarterly_values_HJ72 = quarterly_device_values(@month_count_for_device_HJ72)
    @device_HJ72 = ['HJ-720IT', @quarterly_values_HJ72]

    @month_count_for_device_HJA = month_count_for_device(2013, "HJA")
    @quarterly_values_HJA = quarterly_device_values(@month_count_for_device_HJA)
    @device_HJA = ['HJA-312', @quarterly_values_HJA]


    @month_count_for_device_002 = month_count_for_device(2013, "002")
    @quarterly_values_002 = quarterly_device_values(@month_count_for_device_002)
    @device_002 = ['HJ-322, 323, 324', @quarterly_values_002]

    @devices = [@device_HJ72, @device_HJA, @device_002]
  end
end
