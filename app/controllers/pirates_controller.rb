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
    @month_count_for_device = month_count_for_device(2013, "HJ72")
    @quarterly_device_values = quarterly_device_values(@month_count_for_device)
  end
end
