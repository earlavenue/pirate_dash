class ClientMailer < ActionMailer::Base
  default from: "901banditos@gmail.com"

  def password_reset(client)
    @client = client
    mail to: client.email, subject: "Password Reset"
  end
end
