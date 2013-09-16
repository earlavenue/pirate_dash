class Upload < ActiveRecord::Base
  self.primary_key = "id"
  self.table_name = "of_of_measurements"
  belongs_to :person, foreign_key: :user_id

  scope :within_date_range, ->(start, finish) { where("date >= ? AND date <= ?", start, finish) }

  scope :belonging_to_person, ->(person) { where("user_id = ?", person.user_id )}

  scope :show_page_columns, -> { select("of_of_measurements.user_id, of_of_measurements.date, of_of_measurements.total_steps, of_of_measurements.aerobic_steps, of_of_measurements.calories, of_of_measurements.distance, of_of_measurements.device_serial, of_of_measurements.is_device_input") }

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
