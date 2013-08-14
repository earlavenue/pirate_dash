class Upload < ActiveRecord::Base
  self.table_name = "of_of_measurements"
  belongs_to :person

  scope :within_date_range, lambda { |start, finish| where("date >= ? AND date <= ?", start, finish) }

end
