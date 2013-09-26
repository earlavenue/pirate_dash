module PiratesHelper
  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph", data: {y_values: activations_y_values(2013)})
  end

  def activations_y_values(year)
    (1..12).map do |month|
      if month < 12
        date = "#{year}/#{month + 1}/01".to_date
      else
        date = "#{year + 1}/01/01".to_date
      end
      y_value = Upload.select("count(distinct user_id) as foo").where("date < ?", date).first.foo
      [month, y_value]
    end.to_json
  end

end
