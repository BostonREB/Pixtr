class ImageLikesController <ApplicationController

  def create
    @image = Image.find(params[:id])  #could have pulled out into a method.  "Rule of 2 or 3"
    current_user.like @image
  end

  def destroy
    @image = Image.find(params[:id])
    current_user.unlike @image
  end

end