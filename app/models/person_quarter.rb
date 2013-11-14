class PersonQuarter < ActiveRecord::Base
  belongs_to :person

  def self.create_quarter_record(user_id, start_date)
    q = PersonQuarter.new
    q.person_id = user_id
    q.start_date = start_date
    q.active = false
    q.previous_quarter = false
    q.save
  end

  scope  :active_users, ->(date) { where(start_date: date).where(active: true) }

  scope :users_gained, ->(start_date) { where(:start_date => start_date).where(:active => true).where(:previous_quarter => false) }

  scope :users_lost, ->(start_date) { where(:start_date => start_date).where(:active => false).where(:previous_quarter => true) }

end
