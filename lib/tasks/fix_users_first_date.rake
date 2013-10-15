desc "Fix User's first upload date"
task :fix_users_first_date => [:environment] do

  table = Person.find_by_sql(["select user_id, min(date) as first_upload_date from of_of_measurements where date < '2011-01-01' group by user_id"])
  table.each do |row|
    person = Person.find_by_user_id(row.user_id)

        # create eleven quarter records
        Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2012-04-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2012-01-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2011-10-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2011-07-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2011-04-01'.to_date)
        Quarter.create_quarter_record(row.user_id, '2011-01-01'.to_date)

      end
end
