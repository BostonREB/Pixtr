class GroupLikesController <ApplicationController

  def create
    @group = Group.find(params[:id])  #could have pulled out into a method.  "Rule of 2 or 3"
    current_user.like @group
  end

  def destroy
    @group = Group.find(params[:id])
    current_user.unlike @group
  end

end