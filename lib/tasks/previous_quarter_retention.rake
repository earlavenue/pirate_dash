desc "Check if User was active in previous quarter"
task :previous_quarter_retention => [:environment] do
  PersonQuarter.all.each do |row|
    previous_quarter_start_date = (row.start_date - 3.months).to_date
    previous_row = PersonQuarter.where(:person_id => row.person_id).where(:start_date => previous_quarter_start_date).first

    if previous_row
      if previous_row.active == false
        row.previous_quarter = false
      else
        row.previous_quarter = true
      end
    else
      row.previous_quarter = false
    end
    row.save
  end
end
