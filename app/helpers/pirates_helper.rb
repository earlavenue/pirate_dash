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
      sql = "select count(distinct user_id) from of_of_measurements where date < '#{date}'"
      y_value = ActiveRecord::Base.connection.execute(sql)
      [month, y_value]
    end.to_json
  end

  # def activations_y_values(year)
  #   sql = "SELECT user_id, date FROM of_of_measurements WHERE date < '#{year + 1}/01/01'"
  #   all_uploads_through_year = ActiveRecord::Base.connection.execute(sql)

  #   (1..12).map do |month|
  #     if month < 12
  #       all_uploads_through_month = all_uploads_through_year.reject { |obj| obj[1] == nil || obj[1] >= "#{year}/#{month + 1}/01" }
  #     else
  #       all_uploads_through_month = all_uploads_through_year.reject { |obj| obj[1] == nil || obj[1] >= "#{year+1}/01/01" }
  #     end
  #     user_ids = []
  #     all_uploads_through_month.each do |upload|
  #       user_ids << upload[0]
  #     end
  #     unique_user_ids = user_ids.uniq
  #     y_value = unique_user_ids.length
  #     [month, y_value]
  #   end.to_json
  # end

end
