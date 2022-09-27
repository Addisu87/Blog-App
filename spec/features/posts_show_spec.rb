require 'rails_helper'

RSpec.describe 'Show post page: ', type: :feature do
  before(:each) do
    @user_one = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 0)
    @user_one.save!
    visit root_path

    @post_one = Post.create(title: 'First post', text: 'Hello world!', id: 1, comments_counter: 0, likes_counter: 0,
                            author: @user_one)
    @post_two = Post.create(title: 'Second post', text: 'Quantum Mechanics!', id: 2, comments_counter: 0,
                            likes_counter: 0, author: @user_one)
    @comment_one = Comment.create(author: User.first, post: Post.first, text: 'Rails is awesome!')
    @comment_two = Comment.create(author: User.first, post: Post.first, text: 'Rails is a nice framework!')
    visit user_posts_path(@user_one, @post_one)
  end

  it 'shows the posts title' do
    expect(page).to have_content(@post_two.title)
  end

  it 'shows the name of the author' do
    expect(page).to have_content(@user_one.name)
  end

  it 'shows the number of comments for a post' do
    expect(page).to have_content("Comments: #{@post_one.comments_counter}")
  end

  it 'shows the number of likes for a post' do
    expect(page).to have_content("Likes: #{@post_two.likes_counter}")
  end

  it 'can see the post\'s body.' do
    expect(page).to have_content('Hello world!')
  end

  it 'can see the username of each commentor.' do
    @post = Post.first
    @comment = @post.comments.first
    expect(page).to have_content(@comment.author.name)
  end
end
