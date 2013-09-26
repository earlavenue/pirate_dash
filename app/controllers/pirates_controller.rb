class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron

  include PiratesHelper

  def activations
    unless @year
      @year = Time.now.year
    end
    @y_values_as_array = activations_y_values(@year)
    @y_values_as_json = activations_y_values(@year).to_json
  end
end
