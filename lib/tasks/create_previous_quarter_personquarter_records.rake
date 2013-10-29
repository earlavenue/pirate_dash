desc "Create and set the PersonQuarter records for the previous quarter"
task :create_previous_quarter_personquarter_records => [:environment] do

  @year = Time.now.year

  @q1_start = "#{@year}-01-01".to_date
  @q2_start = "#{@year}-04-01".to_date
  @q3_start = "#{@year}-07-01".to_date
  @q4_start = "#{@year}-10-01".to_date


  current_month = Time.now.month

  quarter_hash = { 1 => @q1_start, 2 => @q1_start, 3 => @q1_start, 4 => @q2_start, 5 => @q2_start, 6 => @q2_start, 7 => @q3_start, 8 => @q3_start, 9 => @q3_start, 10 => @q4_start, 11 => @q4_start, 12 => @q4_start }

  current_quarter = quarter_hash[current_month]
  previous_quarter = current_quarter - 3.months

  unless PersonQuarter.where(start_date: previous_quarter).present?

    # create PQ records for everyone who has uploaded at all
    all_users_who_have_uploaded = Upload.select("distinct user_id")
    all_users_who_have_uploaded.each do |row|
      pq = PersonQuarter.new
      pq.person_id = row.user_id
      pq.active = false
      pq.start_date = previous_quarter

      # set the "previous quarter" boolean -- note: relative to Time.now, this is referring to TWO quarters ago
      two_quarters_ago_start_date = previous_quarter - 3.months
      previous_person_quarter = PersonQuarter.where(person_id: row.user_id).where(start_date: two_quarters_ago_start_date).first
      if previous_person_quarter
        if previous_person_quarter.active == false
          pq.previous_quarter = false
        else
          pq.previous_quarter = true
        end
      else
        pq.previous_quarter = false
      end

      pq.save
    end

    # edit the PQs for users who were active (15+ uploads) during the previous quarter
    active_users_in_previous_quarter = Upload.find_by_sql(["select user_id, count(*) from of_of_measurements where date >= ? and date < ? group by user_id having count(*) > 14", previous_quarter, current_quarter])
    active_users_in_previous_quarter.each do |row|
      q = PersonQuarter.where("person_id = ? and start_date = ?", row.user_id, previous_quarter).first
      q.active = true
      q.save
    end
  end
end
