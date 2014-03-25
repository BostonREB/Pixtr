class LikeActivity < Activity

  def image
    subject.image
  end

  def image_name
    image.name 
  end

  def email
    subject.user.email
  end

end