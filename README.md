# CW Dash
#Change 2
#Test Change
## Codeship Status
https://www.codeship.io/projects/6bff32c0-f30c-0130-3fea-6a9e98eeb1b2/status

Code for Export to Excel in People Index

<% if admin && @organization_id %>
  <p><%= link_to "Export to Excel #{Organization.where(:id => @organization_id).first.name}'s Users' Data", {:controller => "people", :action => "export_to_excel", organization_id: @organization_id}, class: "btn btn-info"  %></p>
<% elsif admin %>
  <p><%= link_to "Export All Users' Data to Excel", {:controller => "people", :action => "export_to_excel"}, class: "btn btn-info"  %></p>
<% else %>
  <p><%= link_to "Export to Excel #{current_client.organization.name}'s Users' Data", {:controller => "people", :action => "export_to_excel"}, class: "btn btn-info"  %></p>
<% end %>