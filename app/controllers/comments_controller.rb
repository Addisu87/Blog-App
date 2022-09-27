class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.author = @user
    @comment.post = @post
    respond_to do |format|
      if @comment.save!
        format.html do
          redirect_to user_post_url(@user, @post), notice: 'Comment was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :author, :post)
  end
end
