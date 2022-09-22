class PostsController < ApplicationController
  http_basic_authenticate_with name: 'Addisu', password: '1987', except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      @post.update_user_post_counter(params[:user_id])
      redirect_to user_post_path(@user.id)
      flash[:notice] = 'Your comment was successfully created'
    else
      redirect_to new_user_post_path(@user.id)
      flash[:notice] = 'An error has occurred while creating the post'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_post_path(current_user, @post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy!

    redirect_to user_posts_path(id: @author.id), notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:tittle, :text, :comments_counter, :likes_counter)
  end
end
