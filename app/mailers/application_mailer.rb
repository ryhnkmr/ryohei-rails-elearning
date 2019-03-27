class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com'
  layout 'mailer'

  def forget_password(user)
    @user = user
    @greeting = "Hi"

    mail to: user.email, :subject => "Reset password instructions"
  end
end
