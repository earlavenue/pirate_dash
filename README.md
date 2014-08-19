# CW Dash
#Change 2
#Test Change
## Codeship Status
https://www.codeship.io/projects/6bff32c0-f30c-0130-3fea-6a9e98eeb1b2/status

####Code for Exporting all info to a CSV
<% if admin && @organization_id %>
  <p><%= link_to "Send Email with All #{Organization.where(:id => @organization_id).first.name}'s Data as CSV", {:controller => "people", :action => "export_to_csv", organization_id: @organization_id}, class: "btn btn-info"  %></p>
<% elsif admin %>
  <p><%= link_to "Export All Users' Data to CSV", {:controller => "people", :action => "export_to_csv"}, class: "btn btn-info"  %></p>
<% else %>
  <p><%= link_to "Send Email with All #{current_client.organization.name}'s Data as CSV", {:controller => "people", :action => "export_to_csv"}, class: "btn btn-info"  %></p>
<% end %>



####Code for Export to Excel Below

Export to excel code for client mailer

 def send_excel(organization_id, client_id)
    @organization = Organization.find(organization_id)
    @client = Client.find(client_id)
    @organization.export_2
    # attachments["excel_for#{@organization.name}"] =File.read("#{Rails.root}/temp_file.csv")
    attachments["excel_for#{@organization.name}.csv"] =File.read(Rails.root.join("temp_file.csv"))
    mail(to: @client.email, subject: "Exported Upload Info for Excel")
  end

Code for Export to Excel in People Index

<% if admin && @organization_id %>
  <p><%= link_to "Export #{Organization.where(:id => @organization_id).first.name}'s Data to Excel", {:controller => "people", :action => "export_to_excel", organization_id: @organization_id}, class: "btn btn-info"  %></p>
<% elsif admin %>
  <p><%= link_to "Export All Users' Data to Excel", {:controller => "people", :action => "export_to_excel"}, class: "btn btn-info"  %></p>
<% else %>
  <p><%= link_to "Export #{current_client.organization.name}'s Data to Excel", {:controller => "people", :action => "export_to_excel"}, class: "btn btn-info"  %></p>
<% end %>

Code for export excel for the controller

  def export_to_excel
    if admin && params[:organization_id]
      if ClientMailer.send_excel(params[:organization_id], current_client.id).deliver
        redirect_to people_path(organization_id: params[:organization_id]), notice: "An email with your organization's uploads will arrive shortly"
      else
        redirect_to people_path(organization_id: params[:organization_id]), notice: "We're sorry something went wrong."
      end
    else
      if ClientMailer.send_excel(Organization.find(current_client.organization.id), current_client.id).deliver
        redirect_to people_path, notice: "An email with your organization's uploads will arrive shortly"
      else
        redirect_to people_path, notice: "We're sorry something went wrong."
      end
    end
  end