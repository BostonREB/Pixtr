class GalleryLikesController <ApplicationController

  def create
    @gallery = find_gallery
    current_user.like @gallery
    render :change
  end

  def destroy
    @gallery = find_gallery
    current_user.unlike @gallery
    render :change
  end

private

  def find_gallery
    Gallery.find(params[:id])
  end

end