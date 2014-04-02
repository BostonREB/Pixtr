class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @images = @tag.images.includes(gallery: [:user])
  end
end