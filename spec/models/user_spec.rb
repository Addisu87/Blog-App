require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'name should not be blank' do
    @user.name = ' '
    expect(@user).to_not be_valid
  end

  it 'photo should be present' do
    @user.photo = nil
    expect(@user).to_not be_valid
  end

  it 'photo should be string' do
    @user.photo = 1
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    @user.posts_counter = 'a'
    expect(@user).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to zero' do
    @user.posts_counter = -1
    expect(@user).to_not be_valid
  end

  it 'posts_counter should return less than three posts' do
    expect(@user.posts_counter).to be < 3
  end
end
