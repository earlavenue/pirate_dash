class ClientMailer < ActionMailer::Base
  default from: "armontdevelopment@gmail.com"

  def password_reset(client)
    @client = client
    mail to: client.email, subject: "Password Reset"
  end

  def send_csv(organization_id, client_id)
    @organization = Organization.find(organization_id)
    @client = Client.find(client_id)
    attachments["csv_for#{@organization.name}"] = @organization.export()
    mail to: @client.email, subject: "Exported Upload Info"
  end
  def send_excel(organization_id, client_id)
    @organization = Organization.find(organization_id)
    @client = Client.find(client_id)
    attachments["excel_for#{@organization.name}"] = @organization.export(col_sep: "\t")
    mail to: @client.email, subject: "Exported Upload Info for Excel"
  end
end
