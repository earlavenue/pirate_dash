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
    @year_info_with_relation = year_info_with_relation(@year)
    @year_info_with_count = activations_y_values(@year_info_with_relation)
    @y_values_as_json = @year_info_with_count.to_json
  end
end
