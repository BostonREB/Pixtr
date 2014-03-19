class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @images = @user.images
  end
end