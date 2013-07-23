class Person < ActiveRecord::Base
  attr_accessible :dev_serial, :km_userid, :omron_userid, :first_name, :last_name, :email

  has_many :uploads
  belongs_to :organization

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

  def self.search_last_name_results(query)
    where(last_name: query)
  end

  # scope :with_last_name, -> { |name| where("last_name = ?", name) }

  def self.search_serial_results(query)
    where(dev_serial: query)
  end


  def lifetime_stats
    all_uploads = self.uploads
    steps_array = []
    all_uploads.each do |upload|
      steps_array << upload.total_steps
    end
    steps = steps_array.inject {|sum, n| sum + n}

    aerobic_array = []
    all_uploads.each do |upload|
      aerobic_array << upload.total_aerobic_steps
    end
    aerobic_steps = aerobic_array.inject {|sum, n| sum + n}

    calories_array = []
    all_uploads.each do |upload|
      calories_array << upload.calories
    end
    calories = calories_array.inject {|sum, n| sum + n}

    distance_array = []
    all_uploads.each do |upload|
      distance_array << upload.distance
    end
    distance = distance_array.inject {|sum, n| sum + n}

    lifetime_hash = {steps: steps, aerobic_steps: aerobic_steps, calories: calories, distance: distance}
  end

  def month_stats(date)
    uploads_for_month = self.uploads.where("upload_time >= ? AND upload_time <= ?", date.beginning_of_month, date.end_of_month)
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

    lifetime_hash = {steps: steps, aerobic_steps: aerobic_steps, calories: calories, distance: distance}

  end


  def lifetime_steps
    p_steps = []
    all_uploads = self.uploads
    all_uploads.each do |upload|
      p_steps << upload.total_steps
    end
    p_steps.inject {|sum, n| sum + n}
  end


  def lifetime_aerobic_steps
    p_steps = []
    all_uploads = self.uploads
    all_uploads.each do |upload|
      p_steps << upload.total_aerobic_steps
    end
    p_steps.inject {|sum, n| sum + n}
  end

  def lifetime_calories
    p_steps = []
    all_uploads = self.uploads
    all_uploads.each do |upload|
      p_steps << upload.calories
    end
    p_steps.inject {|sum, n| sum + n}
  end

  def lifetime_distance
    p_steps = []
    all_uploads = self.uploads
    all_uploads.each do |upload|
      p_steps << upload.distance
    end
    p_steps.inject {|sum, n| sum + n}
  end
end
