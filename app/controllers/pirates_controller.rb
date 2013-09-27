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
    @y_values_as_array = activations_y_values(@year)
    @y_values_as_json = @y_values_as_array.to_json
  end
end
