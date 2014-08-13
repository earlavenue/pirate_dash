class ClientMailer < ActionMailer::Base
  default from: "armontdevelopment@gmail.com"

  def password_reset(client)
    @client = client
    mail to: client.email, subject: "Password Reset"
  end

  def send_csv(organization_id, client_id)
    @organization = Organization.find(organization_id)
    @client = Client.find(client_id)
    @organization.export(@organization.name)
    attachments["csv_for_#{@organization.name}.csv"] =File.read(Rails.root.join("/tmp/#{@organization.name}.csv"))
    mail to: @client.email, subject: "Upload Info in CSV"
    File.delete(Rails.root.join("#{@organization.name}.csv")) if File.exist?(Rails.root.join("#{@organization.name}.csv"))
  end
end
