desc "Set the quarter records for active users to true"
task :set_active_quarters => [:environment] do

  date = "2011-01-01".to_date

  11.times do
    active_users_table = Upload.find_by_sql(["select user_id, count(*) from of_of_measurements where date >= ? and date < ? group by user_id having count(*) > 14", date, date + 3.months])
    active_users_table.each do |row|
      q = Person_quarter.where("person_id = ? and start_date = ?", row.user_id, date).first
      q.active = true
      q.save
    end
    date += 3.months
  end

end
