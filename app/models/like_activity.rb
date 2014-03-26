class LikeActivity < Activity

  def likable
    subject.likable
  end

  def likable_name
    likable.name 
  end

  def email
    subject.user.email
  end

end