module PiratesHelper
  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph", data: {y_values: @y_values_as_json})
  end


  def discrete_month_activations(year)
    (1..13).map do |month|
      if month < 13
        date = "#{year}/#{month}/01".to_date
      else
        date = "#{year + 1}/01/01".to_date
      end
      date1 = date - 1.month
      date2 = date
      y_value = Upload.find_by_sql(["select count(*) as total from (select user_id, min(date) as first_upload from of_of_measurements group by user_id having first_upload between ? AND ?) as count", date1, date2]).first.total
     # y_value = Upload.select("user_id, min(date) as 'first_upload'").group("user_id").having("'first_upload' between ? AND ?", date - 1.month, date).count
      [month, y_value]
    end
  end

  def aggregate_month_activations(discrete_month_activations, year)
    date = "#{year-1}/12/01"
    previous_year_to_december =Upload.find_by_sql(["select count(*) as total from (select user_id, min(date) as first_upload from of_of_measurements group by user_id having first_upload < ?) as count", date]).first.total
    aggregate = []
    iteration = 0
    discrete_month_activations.each do |month_array|
      if month_array[0] == 1
        aggregate << [month_array[0], month_array[1] + previous_year_to_december]
      else
        aggregate << [month_array[0], month_array[1] + aggregate[iteration - 1][1]]
      end
      iteration += 1
    end
    aggregate
  end


  def quarterly_values(aggregate_month_activations)

    q1 = aggregate_month_activations[3][1] - aggregate_month_activations[0][1]
    q2 = aggregate_month_activations[6][1] - aggregate_month_activations[3][1]
    q3 = aggregate_month_activations[9][1] - aggregate_month_activations[6][1]
    q4 = aggregate_month_activations[12][1] - aggregate_month_activations[9][1]

    [q1,q2,q3,q4]
  end
end

