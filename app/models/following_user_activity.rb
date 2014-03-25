class FollowingUserActivity < Activity 

  def followed_user
    subject.followed_user
  end

  def followed_user_name
    followed_user.name 
  end

  def email
    subject.follower.email
  end
end
