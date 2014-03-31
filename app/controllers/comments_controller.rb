class CommentsController < ApplicationController

  def create
    image = Image.find(params[:image_id])
    @comment = image.comments.new(comment_params)
    if @comment.save
      current_user.notify_followers(@comment, image, "CommentActivity")
    else
      redirect_to image, alert: "You cannot add an empty comment"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

private
  def comment_params
    params.require(:comment).
    permit(:body).
    merge(user_id: current_user.id)
  end

end

