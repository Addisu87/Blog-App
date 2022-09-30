class API::CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.html { render json: @post.comments }
      format.json { render json: @post.comments }
    end
  end

  def create
    @comment = Comment.new(text: params[:text], author: User.find(1), post: Post.find(2))

    render json: @comment
  end
end
