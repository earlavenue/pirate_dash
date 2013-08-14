module PeopleHelper

  def render_chart
    if @person.uploads.within_date_range(@date.beginning_of_month, @date.end_of_month + 1.day).exists?
      content_tag(:div, "", id: "user_activity_graph", class: "graph", style: "width:100%;height:300px;", data: {x_values: x_values(@person, @date), y_values: y_values(@person, @date), month: @date.month})
    else
      image_tag("http://space-env.esa.int/Data_Plots/SREM/noData.png")
    end
  end


  private

  def x_values(person, date)
    count = 0
    (date.beginning_of_month..date.end_of_month).map do |date|
        count += 1
        [count, date.strftime("%d")]
    end.to_json
  end

  def y_values(person, date)
    uploads = person.uploads.within_date_range(date.beginning_of_month, date.end_of_month + 1.day)

    count = 0

    (date.beginning_of_month..date.end_of_month).map do |date|
      count += 1
      this_upload = uploads.select { |upload| upload.date.to_date == date }.first
      if this_upload.present?
        [count, this_upload.total_steps]
      else
        [count, 0]
      end
    end.to_json
  end

end
