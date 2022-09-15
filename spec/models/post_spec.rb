require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')

    @post = Post.new(title: 'Post Title', text: 'Post text', likes_counter: 2, comments_counter: 3, author: @user)
  end

  it 'title should be present and not empty' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'title should be present' do
    @post.title = 'Post Title'
    expect(@post).to be_valid
  end

  it 'should have title maximum length of characters 250' do 
    @post.title = 'a' * 251
    expect(@post).to_not be_valid

    @post.title = 'a' * 250
    expect(@post).to be_valid
  end

  it 'text should be present and not empty' do
    @post.text = nil
    expect(@post).to be_valid
  end

  it 'should return comments_counter greater than or equal to zero' do
    @post.comments_counter = -3
    expect(@post).to_not be_valid

    @post.comments_counter = 4
    expect(@post).to be_valid
  end

  it 'should return likes_counter greater than or equal to zero' do
    @post.likes_counter = -7
    expect(@post).to_not be_valid

    @post.likes_counter = 0
    expect(@post).to be_valid
  end

  it 'should have likes_counter numericality' do 
    @post.likes_counter = 'Addisu'
    expect(@post).to_not be_valid

    @post.likes_counter = 8
    expect(@post).to be_valid
  end

  it 'comments_counter should return less than 7 comments' do
    expect(@post.comments_counter).to be < 7
  end
end
