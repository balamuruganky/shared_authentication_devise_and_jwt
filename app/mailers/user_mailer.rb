class UserMailer < ApplicationMailer
  default from: 'your_email_id@gmail.com'

  def send_welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome!")
  end
end
