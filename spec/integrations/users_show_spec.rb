require 'rails_helper'

RSpec.describe 'The show user page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Physics teacher', posts_counter: 2)
    @user.save!
    @post_one = Post.create(title: 'First post', text: 'Hello world!', author_id: @user.id, comments_counter: 0,
                            likes_counter: 0)
    @post_two = Post.create(title: 'Second post', text: 'Quantum Mechanics!', author_id: @user.id, comments_counter: 0,
                            likes_counter: 0)
  end

  it 'show profile pictures fo the user' do
    visit user_path(@user)
    expect(page).to have_selector("img[src='#{@user.photo}']")
  end

  it 'shows username of the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts for the user' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 2')
  end

  it "click on See all posts to redirect to user's post's index page" do
    visit user_path(@user)
    click_link 'See all posts'
    expect(current_path).to eq user_posts_path(@user)
  end
end
