class UserMailer < ActionMailer::Base
  default from: "pixtr@pixtr.org"

  def notice_email(user, activity)
    @user = user
    @activity = activity
    mail(to: @user.email, subject: "There's been activity in Pixtr")
  end

end