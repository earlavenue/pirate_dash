class Quarter < ActiveRecord::Base
  belongs_to :person

  def self.create_quarter_record(user_id, start_date)
    q = Quarter.new
    q.person_id = user_id
    q.start_date = start_date
    q.active = false
    q.save
  end

  def self.active_users(date)
    Quarter.where(start_date: date).where(active: true).count

  # 11.times do
  #   active_users_table = Upload.find_by_sql(["select user_id, count(*) from of_of_measurements where date > ? and date < ? group by user_id having count(*) > 14", date, date + 3.months])
  #   active_users_table.each do |row|
  #     q = Quarter.where("person_id = ? and start_date = ?", row.user_id, date).first
  #     q.active = true
  #     q.save
  #   end
  #   date += 3.months
  # end
  end


end
