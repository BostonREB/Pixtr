class GalleryActivity < Activity


 def gallery
    subject
  end

  def gallery_name
    gallery.name 
  end

  def email
    subject.user.email
  end
end