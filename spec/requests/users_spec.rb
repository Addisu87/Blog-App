require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'assigns all users to @users' do
      get users_path
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe 'GET #index' do
    before(:each) do
      get users_path 
    end 
    
    it 'is a success - 200 code' do
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
