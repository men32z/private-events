# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      user = User.new(name: 'mike guasausky', email: 'miky2@monsteruniversity.com', password: 'password')
      user.save
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'saves a new valid user and returns redirect to users profile route' do
      name_test = 'mike guasausky'
      post :create, params: { user: { name: name_test, email: 'miky2@monsteruniversity.com', password: 'password', password_confirmation: 'password' } }
      expect(User.last.name).to eq(name_test)
      expect(response).to have_http_status(302)
      expect(page).to redirect_to(user_path(User.last.id))
    end
  end
end
