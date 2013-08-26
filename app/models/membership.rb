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

  def self.decode_user_id(params)
    encrypted_and_encoded = params[:membership][:person_id]
    decoded = Base64.decode64 encrypted_and_encoded.encode('ascii-8bit')

    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = "x04xD4xA7xB4sTx12xF3x1Ax9DxD1xC9xA0Hx9Ex86x1Cf1x05VMnxDFMxA3xA9ixDCsxA6"
    decipher.iv = "x11x8Dx02x1A[xCA'xF9xE8.JxADbx06x95x02"

    user_id = decipher.update(decoded) + decipher.final
    return user_id
  end

end
