class Upload < ActiveRecord::Base
  self.primary_key = "id"
  self.table_name = "of_of_measurements"
  belongs_to :person, foreign_key: :user_id

  scope :within_date_range, ->(start, finish) { where("date >= ? AND date <= ?", start, finish) }

  scope :belonging_to_person, ->(person) { where("user_id = ?", person.user_id )}

  scope :show_page_columns, -> { select("of_of_measurements.user_id, of_of_measurements.date, of_of_measurements.total_steps, of_of_measurements.aerobic_steps, of_of_measurements.calories, of_of_measurements.distance, of_of_measurements.device_serial, of_of_measurements.is_device_input") }


  def self.current_quarter_activations(device_model, start_date)
    date1 = start_date
    date2 = start_date + 3.months
    query = <<-END
      select count(*) as total from (
        select device_model, device_serial, min(date) as first_upload
        from of_of_measurements
        where device_model = ?
        group by device_serial
        having first_upload between ? AND ?
      ) as count
    END

    device_count = Upload.find_by_sql([query, device_model, date1, date2]).first.total
  end

  def self.discrete_month_activations(year)
    (1..13).map do |month|
      if month < 13
        date = "#{year}/#{month}/01".to_date
      else
        date = "#{year + 1}/01/01".to_date
      end
      date1 = date - 1.month
      date2 = date
      query = <<-END
        select count(*) as total from (
          select user_id, min(date) as first_upload
          from of_of_measurements
          group by user_id
          having first_upload >= ? and first_upload < ?
        ) as count
      END

      y_value = Upload.find_by_sql([query, date1, date2]).first.total
     # y_value = Upload.select("user_id, min(date) as 'first_upload'").group("user_id").having("'first_upload' between ? AND ?", date - 1.month, date).count
      [month, y_value]
    end
  end

  def self.aggregate_month_activations(discrete_month_activations, year)
    date = "#{year-1}/12/01"
    previous_year_to_december =Upload.find_by_sql(["select count(*) as total from (select user_id, min(date) as first_upload from of_of_measurements group by user_id having first_upload < ?) as count", date]).first.total
    aggregate = []
    iteration = 0
    discrete_month_activations.each do |month_array|
      if month_array[0] == 1
        aggregate << [month_array[0], month_array[1] + previous_year_to_december]
      else
        aggregate << [month_array[0], month_array[1] + aggregate[iteration - 1][1]]
      end
      iteration += 1
    end
    aggregate
  end

  def self.month_stats(uploads)
    if uploads.length != 0
      steps_array = []
      uploads.each do |upload|
        steps_array << upload.total_steps
      end
      steps = steps_array.inject {|sum, n| sum + n}

      aerobic_array = []
      uploads.each do |upload|
        aerobic_array << upload.aerobic_steps
      end
      aerobic_steps = aerobic_array.inject {|sum, n| sum + n}

      calories_array = []
      uploads.each do |upload|
        calories_array << upload.calories
      end
      calories = calories_array.inject {|sum, n| sum + n}

      distance_array = []
      uploads.each do |upload|
        distance_array << upload.distance
      end
      distance = distance_array.inject {|sum, n| sum + n}

      month_hash = {steps: steps, aerobic_steps: aerobic_steps, calories: calories, distance: distance}
    else
      month_hash = {steps: 0, aerobic_steps: 0, calories: 0, distance: 0}
    end
  end
end
