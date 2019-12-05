# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_user) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      user = User.create(valid_user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'saves a new valid user and returns redirect to users profile route' do
      user_test = valid_user
      user_test[:name] = 'mike guasausky'
      post :create, params: { user: user_test }
      expect(User.last.name).to eq(user_test[:name])
      expect(response).to have_http_status(302)
      expect(page).to redirect_to(user_path(User.last.id))
    end
  end
end
