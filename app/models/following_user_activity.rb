class FollowingUserActivity < Activity 

  def followed_user
    target
  end

  def followed_user_name
    target.name 
  end

  def email
    actor.email
  end
end
