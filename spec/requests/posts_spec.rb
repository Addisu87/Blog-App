require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'assigns all users to @posts' do
      get posts_path
      expect(assigns(:posts)).to eq(Post.all)
    end
  end

  describe 'GET #index' do
    before(:example) { get posts_path }
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' 'template" do 
      expect(response).to render_template('index')
    end

    it 'does not render a differnet template' do 
      expect(response).to_not render_template('show')
    end
  end
end
