class GalleriesController < ApplicationController
  before_action :authorize, except: [:show] #runs filter for everything but "show" action

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
    @gallery = current_user.galleries.new(gallery_params)  #creates gallery that belongs to user
    if @gallery.save
      redirect_to @gallery
    else
      render :new #only renders the template and displays the previously entered data o user can make changes
    end
  end 

  def edit
    @gallery = current_user.galleries.find(params[:id])
  end

  def update
    @gallery = current_user.galleries.find(params[:id])
    if @gallery.update(gallery_params)
      redirect_to @gallery
    else
      render :edit
    end
  end

  def destroy
    gallery = current_user.galleries.find(params[:id])
    gallery.destroy
    redirect_to galleries_path
  end

private
  def gallery_params
    params.require(:gallery).permit(:name)
  end
end
