class CommentActivity < Activity 


 def image
    target
  end

  def image_name
    target.name 
  end

  def email
    actor.email
  end

  def body
    subject.body
  end
  
end