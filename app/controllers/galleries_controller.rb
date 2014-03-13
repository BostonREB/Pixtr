class GalleriesController < ApplicationController
  def index   #actions are just methods.  Here it's the action "index"
    #any method inside the Controller is an "Action"
    ## renders a view, in this case the "index" view.
    @galleries = current_user.galleries  #just gives galleries for current_user  
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
    @gallery = Gallery.new
  end 

  def create
    gallery = current_user.galleries.create(gallery_params)  #creates gallery that belongs to user
    redirect_to gallery_path(gallery)
  end 

  def edit
    @gallery = current_user.galleries.find(params[:id])
  end

  def update
    gallery = current_user.galleries.find(params[:id])
    gallery.update(gallery_params)
    redirect_to gallery
  end

  def destroy
    gallery = current_user.galleries.find(params[:id])
    gallery.destroy
    redirect_to root_path
  end

private
  def gallery_params
    params.require(:gallery).permit(:name)
  end
end
