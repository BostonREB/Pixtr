class ImagesController < ApplicationController

  def index
    if params[:tag]
      @images = Image.tagged_with(params[:tag])
    else
      @images = current_user.images
    end 

    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end
  end

  def new
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = @gallery.images.new(image_params)

    if @image.save
      current_user.notify_followers(@image, @image, "ImageActivity")
      redirect_to @gallery
    else
      render :new #only renders the template and displays the previously entered data o user can make changes
    end
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.newest.page(params[:page]).per(3).includes(:user)
    @tags = @image.tags
  end

  def edit
    @image = current_user.images.find(params[:id])
    @groups = current_user.groups
  end

  def update 
    @image = current_user.images.find(params[:id])
    
    if @image.update(image_params)
      redirect_to @image
    else
      @groups = current_user.groups
      render :edit
    end
  end

  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    redirect_to image.gallery
  end

 #VVV same as above before image was changed in model
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
      :description,
      :tag_list,
      group_ids: []
    )
  end

end