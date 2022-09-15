require 'spec_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0)

    @post = Post.new(title: 'Post Title', text: 'Post text', likes_counter: 2, comments_counter: 3, author: @user)
  end

  # it 'title should be present and not empty' do 
  #   @post.title = nil
  #   expect(@post).to_not be_valid
  # end
end