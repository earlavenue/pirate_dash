class Quarter < ActiveRecord::Base
  belongs_to :person

  private

  def get_activity_for_quarter
    active_users_table = Upload.select("user_id, count(*) where date > ? and date < ? group by user_id having count(*) > 14", "2013-01-01".to_date, "2013-04-01".to_date)
    active_users_table.each do |row|
      q = Quarter.new
      q.user_id = row.user_id
      q.start_date = "2013-01-01"
      q.active = true
    end
  end


end