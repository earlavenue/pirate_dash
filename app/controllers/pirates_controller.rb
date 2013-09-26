class PiratesController < ApplicationController
  before_action :require_signin
  before_action :require_omron

  include PiratesHelper

  def activations
    @activations_y_values = activations_y_values(2013)

  end
end
