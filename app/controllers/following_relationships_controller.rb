class FollowingRelationshipsController < ApplicationController

  def create
    followed_user = User.find(params[:id])
    current_user.following_relationships.create(followed_user_id: followed_user.id)
    redirect_to followed_user
  end
end