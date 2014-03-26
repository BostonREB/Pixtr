class GalleryLikesController <ApplicationController

  def create
    @gallery = Gallery.find(params[:id])
    current_user.like @gallery
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    current_user.unlike @gallery
  end

end