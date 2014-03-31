class GalleryLikesController <ApplicationController

  def create
    @gallery = Gallery.find(params[:id])
    current_user.like @gallery
    render :change
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    current_user.unlike @gallery
    render :change
  end

end