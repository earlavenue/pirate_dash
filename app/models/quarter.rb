class Quarter < ActiveRecord::Base
  belongs_to :person

  def self.create_quarter_record(user_id, start_date)
    q = Quarter.new
    q.person_id = user_id
    q.start_date = start_date
    q.active = false
    q.save
  end


  # # this is a rake task, once we get there; it also needs to be modified
  # def set_active_users_for_quarter(start_date)
  #   date1 = start_date
  #   date2 = start_date + 3.months
  #   active_users_table = Upload.find_by_sql(["select user_id, count(*) from of_of_measurements where date > ? and date < ? group by user_id having count(*) > 14", date1, date2])
  #   active_users_table.each do |row|
  #     q = Quarter.new
  #     q.user_id = row.user_id
  #     q.start_date = start_date
  #     q.active = true
  #     q.save
  #   end
  # end

end
