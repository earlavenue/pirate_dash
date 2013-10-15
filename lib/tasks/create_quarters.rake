desc "Make quarter records for people"
task :create_quarters => [:environment] do

  table = Person.find_by_sql(["select user_id, min(date) as first_upload_date from of_of_measurements where date != '0000-00-00 00:00:00' group by user_id"])

  table.each do |row|
    person = Person.find_by_user_id(row.user_id)
    if row.first_upload_date >= '2013-07-01'.to_date && row.first_upload_date < '2013-10-01'.to_date # 2013 Q3
      # create one quarter record
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)

    elsif row.first_upload_date >= '2013-04-01'.to_date && row.first_upload_date < '2013-07-01'.to_date # 2013 Q2
      # create two quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)

    elsif row.first_upload_date >= '2013-01-01'.to_date && row.first_upload_date < '2013-04-01'.to_date # 2013 Q1
      # create three quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)

    elsif row.first_upload_date >= '2012-10-01'.to_date && row.first_upload_date < '2013-01-01'.to_date # 2012 Q4
      # create four quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)

    elsif row.first_upload_date >= '2012-07-01'.to_date && row.first_upload_date < '2012-10-01'.to_date # 2012 Q3
      # create five quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)

    elsif row.first_upload_date >= '2012-04-01'.to_date && row.first_upload_date < '2012-07-01'.to_date # 2012 Q2
      # create six quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-04-01'.to_date)

    elsif row.first_upload_date >= '2012-01-01'.to_date && row.first_upload_date < '2012-04-01'.to_date # 2012 Q1
      # create seven quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-01-01'.to_date)

    elsif row.first_upload_date >= '2011-10-01'.to_date && row.first_upload_date < '2012-01-01'.to_date # 2011 Q4
      # create eight quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2011-10-01'.to_date)

    elsif row.first_upload_date >= '2011-07-01'.to_date && row.first_upload_date < '2011-10-01'.to_date # 2011 Q3
      # create nine quarter records
      Quarter.create_quarter_record(row.user_id, '2013-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2013-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-07-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-04-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2012-01-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2011-10-01'.to_date)
      Quarter.create_quarter_record(row.user_id, '2011-07-01'.to_date)

    elsif row.first_upload_date >= '2011-04-01'.to_date && row.first_upload_date < '2011-07-01'.to_date # 2011 Q2
      # create ten quarter records
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

    elsif row.first_upload_date >= '2011-01-01'.to_date && row.first_upload_date < '2011-04-01'.to_date # 2011 Q1
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

    elsif row.first_upload_date < '2011-01-01'.to_date

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

    end # ends the if/elsif statement
  end # ends the do block
end # ends the rake task
