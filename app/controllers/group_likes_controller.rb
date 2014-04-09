class GroupLikesController <ApplicationController

  def create
    @group = find_group
    current_user.like @group
    render :change
  end

  def destroy
    @group = find_group
    current_user.unlike @group
    render :change
  end

  private

  def find_group
    Group.find(params[:id])
  end

end