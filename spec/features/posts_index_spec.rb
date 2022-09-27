require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  before(:each) do
    @user = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 0)
    @user.save!
    visit root_path

    @post_one = Post.create(author: @user, title: 'First post', text: 'Hello world!', id: 1, comments_counter: 0, likes_counter: 0)
    @post_two = Post.create(author: @user, title: 'Second post', text: 'Quantum Mechanics!', id: 2, comments_counter: 0,
                            likes_counter: 0)

    @comment_one = Comment.create(title: 'First comment', author: User.first, post: Post.first)
    @comment_two = Comment.create(title: 'Second comment', author: User.first, post: Post.first)
    visit(user_path(id: @user))
  end

  it 'Shows the uses profile picture' do
    visit(user_posts_path(@user.id))
    expect(page).to have_css('img[src*="img_1.png"]')
  end

  it 'shows username of the user' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('Addisu')
  end

  it 'shows number of posts of user has written' do
    visit(user_posts_path(@user.id))
    post = Post.all
    expect(post.size).to eql(2)
  end

  it 'shows post title' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('First post')
  end

  it 'shows post\' text' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('Hello world!')
  end

  it 'redirects to the post\'s show page when clicked' do
    click_on 'First post'
    expect(page).to have_current_path user_path(@user)
    expect(page).to have_content('Hello world!')
  end
end
