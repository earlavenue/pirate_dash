module PiratesHelper
  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph", data: {y_values: @y_values_as_json})
  end

  def year_info_with_relation(year)
    (1..13).map do |month|
      if month < 13
        date = "#{year}/#{month}/01".to_date
      else
        date = "#{year+ 1}/01/01".to_date
      end
      relation = Upload.select("distinct user_id, device_serial").where("date <= ?", date).all
      [month, relation]
    end
  end

  def activations_y_values(year_info_with_relation)

    year_info_with_count = []
    year_info_with_relation.each do |month_array|
      year_info_with_count << [month_array[0], month_array[1].count]
    end
    year_info_with_count
  end

  def quarterly_values(year_info_with_count)

    q1 = year_info_with_count[3][1] - year_info_with_count[0][1]
    q2 = year_info_with_count[6][1] - year_info_with_count[3][1]
    q3 = year_info_with_count[9][1] - year_info_with_count[6][1]
    q4 = year_info_with_count[12][1] - year_info_with_count[9][1]

    [q1,q2,q3,q4]

  end
end
