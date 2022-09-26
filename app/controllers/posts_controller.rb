class PostsController < ApplicationController
  http_basic_authenticate_with name: 'Addisu', password: '1987', except: %i[index show]

  def index
    @user = current_user
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
    @user = current_user
    @post.author = @user

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

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to user_post_path(@user, @post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:posts_counter)
    @post.destroy

    redirect_to user_posts_path(id: @author.id), notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:tittle, :text)
  end
end
