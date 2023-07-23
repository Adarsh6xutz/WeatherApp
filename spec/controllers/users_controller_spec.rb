require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    it 'should create a new user and redirects to login page' do
      post :create, params: { user: { username: 'fake username', password: 'fake password' } }
      expect(User.count).to eq(1)
      expect(response).to redirect_to(login_path)
    end

    it 'should not create the user if user name is not present or its length is less than 3' do
      post :create, params: { user: { username: '', password: 'fake password' } }
      expect(User.count).to eq(0)
    end
  end

  describe 'Login' do
    before do
      post :create, params: { user: { username: 'fake username', password: 'fake password' } }
    end
    it 'should login user with valid credential' do
      get :login, params: { username: 'fake username', password: 'fake password' }
      expect(response).to redirect_to(root_path)
    end

    it 'should not login user with invalid credential' do
      get :login, params: { username: 'fake', password: 'fake password' }
      expect(response).to render_template(root_path)
    end
  end

  describe 'Logout' do
    before do
      post :create, params: { user: { username: 'fake username', password: 'fake password' } }
    end
    it 'should logout and clear the session' do
      get :login, params: { username: 'fake username', password: 'fake password' }

      expect(response).to redirect_to(root_path)
      expect(session[:user_id].nil?).to be_falsey

      delete :destroy_session, params: { id: '121' }

      expect(session[:user_id].nil?).to be_truthy
      expect(response).to redirect_to(root_path)
    end
  end
end
