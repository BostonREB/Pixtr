class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @images = @user.images.includes(gallery: [:user])
  end
end