require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create and GET #show" do
    it "creates an event with valid information" do
      user = User.create(name:"mike guasausky", email: "miky2@monsteruniversity.com", password:'password')
      session[:user_id] = user.id
      name_test = "event1"
      post :create, params: {event: {name:name_test, description: "nice desc.", date: Date.tomorrow}}
      expect(Event.last.name).to eq(name_test)
      expect(response).to have_http_status(302)
      expect(page).to redirect_to(events_path)

      get :show, params: {id: Event.last.id}
      expect(response).to have_http_status(:success)
    end
  end
end
