class ImageLikesController <ApplicationController

  def create
    image = Image.find(params[:id])
    current_user.like image
    redirect_to image
  end

  def destroy
    image = Image.find(params[:id])
    current_user.unlike image
    redirect_to image
  end

end