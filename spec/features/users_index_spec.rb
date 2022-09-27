require 'rails_helper'

RSpec.describe 'user index view', type: :feature do
  describe 'GET /users/index' do
    before(:each) do
      @user_one = User.create(name: 'Addisu', photo: 'img_1.png', bio: 'Full-Stack Developer', posts_counter: 2)
      @user_one.save!
      @user_two = User.create(name: 'Yonas', photo: 'img_2.png', bio: 'Full-Stack Developer', posts_counter: 3)
      @user_two.save!
    end

    it 'Show username of each user' do
      visit root_path
      expect(page).to have_content('Addisu')
      expect(page).to have_content('Yonas')
    end

    it 'Shows the uses profile picture' do
      visit root_path
      expect(page).to have_css('img[src*="img_1.png"]')
      expect(page).to have_css('img[src*="img_2.png"]')
    end

    it 'Shows the number of posts of each user' do
      visit root_path
      expect(page).to have_content('2')
      expect(page).to have_content('3')
    end

    it 'redirects to the user\'s show page when clicked' do
      click_on 'Addisu'
      expect(page).to have_current_path user_path(@user_one)
      expect(page).to have_content('Physics teacher')
    end
  end
end
