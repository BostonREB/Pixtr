class GalleryActivity < Activity


 def gallery
    target
  end

  def gallery_name
    target.name 
  end

  def email
    actor.email
  end
end