require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  
  describe 'DELETE #destroy' do
    it "return redirection" do
      delete :destroy
      expect(page).to redirect_to(home_path)
    end

    it "logs out"
  end
end
