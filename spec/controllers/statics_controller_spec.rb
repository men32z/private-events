# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticsController, type: :controller do
  describe 'GET #index' do
    it 'go to home path succefuly' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
