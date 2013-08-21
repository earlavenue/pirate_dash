class Membership < ActiveRecord::Base
  belongs_to :person
  belongs_to :organization
  validates :organization_id, :presence => true
  validates :person_id, :presence => true

  def self.set_first_upload_date(person)
    m = Membership.find_by_person_id(person.user_id)
    m.first_upload_date = person.uploads.first.date.to_date
    m.save
    return m.first_upload_date
  end
end
