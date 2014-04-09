class FollowerNotifier
  def initialize(user)
    @user = user
  end

  def notify(subject, target, type)
    if subject.persisted?
      @user.followers.each do |follower|
        activity = follower.activities.create(
          subject: subject,  #polymorphic association
          type: type,  #single table inheritence
          actor: user,
          target: target)
        UserMailer.notice_email(follower, activity)
      end
    end
  end
  handle_asynchronously :notify

private
attr_reader :user  #allows you to use "user" as opposed to "@user" for same object
#also allows for more flexibilityin code
end