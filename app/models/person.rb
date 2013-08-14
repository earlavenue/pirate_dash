class Person < ActiveRecord::Base
  self.table_name = "of_of_users"
  self.primary_key = "user_id"

  has_many :uploads, foreign_key: :user_id, order: 'date ASC'
  has_one :membership
  has_one :organization, through: :membership

  scope :order_by_organization, -> { joins(:organization).order("organizations.name") }

  scope :from_organization, ->(organization_id) { joins(:organization).where("organization_id = ?", organization_id)}

  scope :with_last_name, ->(name) { where("last_name = ?", name) }


  def month_stats(date)
    uploads_for_month = self.uploads.select{ |u| u.date >= date.beginning_of_month && u.date <= date.end_of_month }
    if uploads_for_month.count > 0
      steps_array = []
      uploads_for_month.each do |upload|
        steps_array << upload.total_steps
      end
      steps = steps_array.inject {|sum, n| sum + n}

      aerobic_array = []
      uploads_for_month.each do |upload|
        aerobic_array << upload.aerobic_steps
      end
      aerobic_steps = aerobic_array.inject {|sum, n| sum + n}

      calories_array = []
      uploads_for_month.each do |upload|
        calories_array << upload.calories
      end
      calories = calories_array.inject {|sum, n| sum + n}

      distance_array = []
      uploads_for_month.each do |upload|
        distance_array << upload.distance
      end
      distance = distance_array.inject {|sum, n| sum + n}

      month_hash = {steps: steps, aerobic_steps: aerobic_steps, calories: calories, distance: distance}
    else
      month_hash = {steps: 0, aerobic_steps: 0, calories: 0, distance: 0}
    end
  end
end
