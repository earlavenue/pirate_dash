class Quarter < ActiveRecord::Base
  belongs_to :person

  def self.create_quarter_record(user_id, start_date)
    q = Quarter.new
    q.person_id = user_id
    q.start_date = start_date
    q.active = false
    q.save
  end

end
