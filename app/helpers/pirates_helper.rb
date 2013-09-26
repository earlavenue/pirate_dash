module PiratesHelper
  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph", data: {y_values: @y_values_as_json})
  end

  def activations_y_values(year)
    (1..13).map do |month|
      if month < 13
        date = "#{year}/#{month}/01".to_date
      else
        date = "#{year + 1}/01/01".to_date
      end
      y_value = Upload.select("count(distinct user_id) as foo").where("date <= ?", date).first.foo
      [month, y_value]
    end
  end

  def quarterly_values(year_info)

    q1 = year_info[3][1] - year_info[0][1]
    q2 = year_info[6][1] - year_info[3][1]
    q3 = year_info[9][1] - year_info[6][1]
    q4 = year_info[12][1] - year_info[9][1]

    [q1,q2,q3,q4]

  end

end
