class GalleryLikesController <ApplicationController

  def create
    gallery = Gallery.find(params[:id])
    current_user.like gallery
    redirect_to gallery
  end

  def destroy
    gallery = Gallery.find(params[:id])
    current_user.unlike gallery
    redirect_to gallery
  end

end