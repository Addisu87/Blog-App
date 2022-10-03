class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /posts
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  # GET /posts/1
  def show
    @post = Post.find(params[:id])
    @user = current_user
    authorize! :read, @post
  end

  def new
    @post = Post.new
    @user = current_user
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @user = current_user
    @post.author = @user
    @post.comments_counter = 0
    @post.likes_counter = 0

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_url(@user, @post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  # PATCH/PUT /posts/1
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_post_path(@user, @post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy

    redirect_to user_posts_url(id: @author.id), notice: 'Post was successfully deleted'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
