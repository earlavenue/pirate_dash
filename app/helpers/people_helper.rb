module PeopleHelper

  def render_chart
    if @month_stats_hash[:steps] != 0
      content_tag(:div, "", id: "user_activity_graph", class: "graph", style: "width:100%;height:300px;", data: {x_values: x_values(@date), y_values: y_values(@uploads, @date), month: @date.month})
    else
      image_tag("no_data_available.jpg", style:"pointer-events: none;")
    end
  end

  def activations_chart
    content_tag(:div, "", id: "statsChart", class: "graph")
  end


  private

  def x_values(date)
    count = 0
    (date.beginning_of_month..date.end_of_month).map do |date|
        count += 1
        [count, date.strftime("%d")]
    end.to_json
  end

  def y_values(uploads, date)
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
