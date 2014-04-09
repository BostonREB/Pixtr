class GalleriesController < ApplicationController
  before_action :authorize, except: [:show] #runs filter for everything but "show" action
  respond_to :html, :js

  def index   #actions are just methods.  Here it's the action "index"
    #any method inside the Controller is an "Action"
    ## renders a view, in this case the "index" view.
    @galleries = current_user.galleries  #just gives galleries for current_user 
    if params[:search]
    @images = Image.search(params[:search]).order("created_at DESC")
    else
    @images = Image.all.order('created_at DESC')
    end  
  end

  def show
    @gallery = Gallery.find(params[:id])
    @images = @gallery.images.includes(gallery: [:user])
  end

  def new
    @gallery = Gallery.new
  end 

  def create
    @gallery = current_user.galleries.new(gallery_params)  #creates gallery that belongs to user
    if @gallery.save
      notify_followers(@gallery, @gallery, "GalleryActivity")
      redirect_to @gallery
    else
      render :new #only renders the template and displays the previously entered data o user can make changes
    end
  end 

  def edit
    @gallery = find_gallery
  end

  def update
    @gallery = find_gallery
    @gallery.update(gallery_params)
    respond_with @gallery
  end

  def destroy
    gallery = find_gallery
    gallery.destroy
    redirect_to galleries_path
  end

private

  def gallery_params
    params.require(:gallery).permit(:name)
  end

  def find_gallery
    current_user.galleries.find(params[:id])
  end
  
end

