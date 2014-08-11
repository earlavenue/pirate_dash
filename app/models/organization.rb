class Organization < ActiveRecord::Base

  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :code, :presence => true
  validates :code, :uniqueness => true

  has_many :memberships
  has_many :people, through: :memberships
  has_many :uploads, through: :people
  has_many :clients

  def export
    csv_string = CSV.generate do |csv|
      csv << ["Name", "Upload Date", "Steps", "Aerobic Steps", "Calories", "Miles", "Device Serial", "Input Method"]
      self.uploads.includes(:person).find_each(batch_size: 7000) do |upload|
        if upload.is_device_input == 1
          input_method = "Synced from Device"
        else
          input_method = "Manually Uploaded"
        end
        csv << ["#{upload.person.first_name} #{upload.person.last_name}", upload.date.try(:strftime, "%b %d %Y"), upload.total_steps, upload.aerobic_steps, upload.calories, ('%.2f' % upload.distance), upload.device_serial, input_method]
      end
    end
  end
end
