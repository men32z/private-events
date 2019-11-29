require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET users#new" do
    it "show form" do
      expect(get: new_users_path).
        to route_to(controller: "users", action: "new")
    end
  end
end
