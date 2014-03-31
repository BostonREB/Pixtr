class LikeActivity < Activity

  def likable
    target
  end

  def likable_name
    likable.name 
  end

  def email
    actor.email
  end

end