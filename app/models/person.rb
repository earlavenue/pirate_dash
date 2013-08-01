class Person < ActiveRecord::Base
  attr_accessible :dev_serial, :km_userid, :omron_userid, :first_name, :last_name, :email

  has_many :uploads
  belongs_to :organization

  scope :order_by_organization, -> { self.joins(:organization).order("organizations.name") }

  scope :from_organization, ->(organization_id) { where("organization_id = ?", organization_id)}

  scope :with_last_name, ->(name) { where("last_name = ?", name) }

  scope :with_dev_serial, ->(dev_serial) { where("dev_serial = ?", dev_serial) }


  def self.import(file, org)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      person = Person.new
      person.first_name = row_hash["User Name"].split(" ")[0]
      person.last_name = row_hash["User Name"].split(" ")[1]
      person.email = person.last_name + "@gmail.com"
      person.dev_serial = "HJ" + rand(9383838).to_s
      person.organization_id = org
        if Person.find_by_last_name(person.last_name)
        else
          person.save!
        end
    end
  end


  def month_stats(date)
    uploads_for_month = self.uploads.select{ |u| u.upload_time >= date.beginning_of_month && u.upload_time <= date.end_of_month }
    if uploads_for_month.count > 0
      steps_array = []
      uploads_for_month.each do |upload|
        steps_array << upload.total_steps
      end
      steps = steps_array.inject {|sum, n| sum + n}

      aerobic_array = []
      uploads_for_month.each do |upload|
        aerobic_array << upload.total_aerobic_steps
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
