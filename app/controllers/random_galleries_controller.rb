class RandomGalleriesController < ApplicationController

  def show
    gallery = Gallery.all.sample
    redirect_to gallery_path(@gallery)
  end 

end