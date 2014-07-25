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
    @discrete_month_activations = Upload.discrete_month_activations(@year)
    @aggregate_month_activations = Upload.aggregate_month_activations(@discrete_month_activations, @year)
    @y_values_as_json = @aggregate_month_activations.to_json
  end


  def devices
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end

    current_quarter = Time.now.beginning_of_quarter.to_date

    @device_hash = Hash.new
    date = "#{@year}-01-01".to_date
    4.times do |i|
      if current_quarter == date
        @device_hash["HJ-720_#{date}"] = Upload.current_quarter_activations("HJ-720", current_quarter)
        @device_hash["HJ-322_#{date}"] = Upload.current_quarter_activations("HJ-322", current_quarter)
        @device_hash["HJA-312_#{date}"] = Upload.current_quarter_activations("HJA-312", current_quarter)
      elsif current_quarter < date
        @device_hash["HJ-720_#{date}"] = "-"
        @device_hash["HJ-322_#{date}"] = "-"
        @device_hash["HJA-312_#{date}"] = "-"
      else
        @device_hash["HJ-720_#{date}"] = Rails.cache.read("HJ-720_#{date}")
        @device_hash["HJ-322_#{date}"] = Rails.cache.read("HJ-322_#{date}")
        @device_hash["HJA-312_#{date}"] = Rails.cache.read("HJA-312_#{date}")
      end
      date += 3.months
    end
  end


  def retention
    if params[:year]
      @year = params[:year].to_i
    else
      @year = Time.now.year
    end
  end


  def users_lost
    @start_date = params[:quarter]
    @person_quarters = PersonQuarter.users_lost(@start_date)
  end
end
