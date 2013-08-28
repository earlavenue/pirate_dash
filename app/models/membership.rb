class Membership < ActiveRecord::Base
  attr_accessible :person_id, :organization_id
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

  def self.decode_user_id(encrypted_and_encoded)
    decoded = Base64.decode64 encrypted_and_encoded.encode('ascii-8bit')

    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = ENV['CW_DASH_KEY']
    decipher.iv = ENV['CW_DASH_IV']

    user_id = decipher.update(decoded) + decipher.final
    return user_id
  end

end
