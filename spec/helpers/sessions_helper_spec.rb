require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  let(:user) {@user = User.create(name:"mike guasausky", email: "miky@monsteruniversity.com", password:'password')}
  describe  "log_in method" do
    it "log you in" do
      log_in(user)
      expect(session[:user_id]).to eq(1)
    end
  end
  describe  "current_user method" do
    it "returns current user when there is user" do
      log_in(user)
      expect(current_user.id).to eq(user.id)
    end

    it "returns nil when there is not user" do
      expect(current_user).to eq(nil)
    end
  end

  describe "logged_in?" do
    it "returns true if the user is logged in or false if not" do
        expect(logged_in?).to eq(false)
        log_in(user)
        expect(logged_in?).to eq(true)
    end
  end

  describe "sign_out method" do
    it "log out the user" do
      log_in(user)
      expect(logged_in?).to eq(true)
      sign_out
      expect(logged_in?).to eq(false)
      expect(session[:user_id]).to eq(nil)
      expect(current_user).to eq(nil)
    end
  end
end
