class API::PostsController < ApplicationController
  # GET /posts
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end
end
