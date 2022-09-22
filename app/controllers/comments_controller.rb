class CommentsController < ApplicationController
  def new
    @comment = Commment.new
    @user = current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_user.id
    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :status)
  end
end
