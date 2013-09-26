class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron

  include PiratesHelper

  def activations
    @y_values_as_array = activations_y_values(2013)
    @y_values_as_json = activations_y_values(2013).to_json
  end
end
