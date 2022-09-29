class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.author = @user
    @comment.post = @post
    respond_to do |format|
      format.html do
        if @comment.save!
          flash[:success] = 'Comment was successfully created.'
          redirect_to user_post_url(@user, @post)
        else
          flash.now[:error] = 'Error: Comment could not be created.'
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :author, :post)
  end
end
