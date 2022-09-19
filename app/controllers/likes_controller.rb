class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(params[:id])
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id])
    @like.destroy
    redirect_to post_path(@post)
  end
end
