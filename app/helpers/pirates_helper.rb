module PiratesHelper
  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph", data: {y_values: activations_y_values('2013')})
  end

  def activations_y_values(year)
    final_array = []
    12.times do |count|
      month = count + 1
      target_month = (month + 1).to_s
      date = "#{year} - #{target_month} - 1"
      sql = "SELECT COUNT( * ) FROM (SELECT DISTINCT user_id FROM (SELECT user_id, DATE FROM of_of_measurements WHERE DATE < #{date}) AS uploads_to_date) AS distinct_uploads"
      y_value = ActiveRecord::Base.connection.execute(sql).first
      final_array << [month, y_value]
    end
    return final_array.to_json
  end
end
