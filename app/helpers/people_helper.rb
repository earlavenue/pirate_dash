module PeopleHelper
  def x_values(person, date)
    count = 0
    # (person.uploads.first.upload_time.to_date..person.uploads.last.upload_time.to_date).map do |date|
    (date.beginning_of_month..date.end_of_month).map do |date|
        count += 1
        [count, date.strftime("%d")]
    end.to_json
  end

  def y_values(person, date)
    count = 0
    # (person.uploads.first.upload_time.to_date..person.uploads.last.upload_time.to_date).map do |date|
    (date.beginning_of_month..date.end_of_month).map do |date|
      count += 1
      if person.uploads.find_by_upload_time(date).present?
        [count, person.uploads.find_by_upload_time(date).total_steps]
      else
        [count, 0]
      end

    end.to_json
  end
end
