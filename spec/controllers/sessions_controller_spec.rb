# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user_valid) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  describe 'DELETE #destroy' do
    it 'return redirection' do
      delete :destroy
      expect(page).to redirect_to(home_path)
    end
  end

  describe 'POST #create' do
    it 'go to profile on valid log in' do
      user = User.create(user_valid)
      post :create, params: { user_id: user.id }
      expect(page).to redirect_to user_path(user)
      expect(session[:user_id]).to eq(user.id)
    end

    it 'flash error message and session is nil on invalid login' do
      user = User.create(user_valid)
      post :create, params: { user_id: user.id + 1 }
      expect(session[:user_id]).to eq(nil)
      expect(flash).to_not be_empty
    end
  end
end
