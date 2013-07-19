module PeopleHelper
  def x_values(person)
    count = 0
    (person.uploads.first.upload_time.to_date..person.uploads.last.upload_time.to_date).map do |date|
        count += 1
        [count, date.strftime("%b/%d")]
    end.to_json
  end

  def y_values(person)
    count = 0
    (person.uploads.first.upload_time.to_date..person.uploads.last.upload_time.to_date).map do |date|
      count += 1
      [count, person.uploads.find_by_upload_time(date)]
    end.to_json
  end
end
