module PeopleHelper
  def x_values(person, date)
    count = 0
    (date.beginning_of_month..date.end_of_month).map do |date|
        count += 1
        [count, date.strftime("%d")]
    end.to_json
  end

  def y_values(person, date)
    uploads = person.uploads.within_date_range(date.beginning_of_month, date.end_of_month)

    count = 0

    (date.beginning_of_month..date.end_of_month).map do |date|
      count += 1
      this_upload = uploads.select { |upload| upload.upload_time == date }.first
      if this_upload.present?
        [count, this_upload.total_steps]
      else
        [count, 0]
      end
    end.to_json
  end

end
