class Person_Quarter < ActiveRecord::Base
  belongs_to :person

  def self.create_quarter_record(user_id, start_date)
    q = Person_quarter.new
    q.person_id = user_id
    q.start_date = start_date
    q.active = false
    q.save
  end

  def self.active_users(date)
    Person_quarter.where(start_date: date).where(active: true).count
  end


end
