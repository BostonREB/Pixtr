class GroupMembershipsController < ApplicationController

  def create
    @group = find_group
    group_membership = current_user.join @group
    notify_followers(group_membership, @group, "GroupMembershipActivity")
    render :change
  end

  def destroy
    @group = find_group
    current_user.leave(@group)
    render :change
  end

  private
  def find_group
    Group.find(params[:id])
  end

end