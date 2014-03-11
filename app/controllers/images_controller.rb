class ImagesController < ApplicationController

  def new
    @gallery = Gallery.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    gallery = Gallery.find(params[:gallery_id])
    gallery.images.create(image_params)
    redirect_to gallery
  end

  def show
    @image = Image.find(params[:id])
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update 
    image = Image.find(params[:id])
    image.update(image_params)
    redirect_to image
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to image.gallery
  end

  #VVV same as above before Image was changed in model
  # def destroy
  #   image = Image.find(params[:id])
  #   image.destroy
  #   redirect_to gallery_path(image.gallery_id)
  # end

private

  def image_params
    params.require(:image).permit(
      :name, 
      :url, 
      :description
    )
  end

end