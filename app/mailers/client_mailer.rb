class ClientMailer < ActionMailer::Base
  default from: "armontdevelopment@gmail.com"

  def password_reset(client)
    @client = client
    mail to: client.email, subject: "Password Reset"
  end
end
