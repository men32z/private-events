require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:valid_user) {{ name:'mike', email:'mikew@monsterinc.com', password:'wasausky'}}
  let(:valid_event_without_user) {{ name:'event 1', description: "a nice description", date: Date.tomorrow}}
  it "is valid with valid attributes" do
    user = User.create(valid_user)
    new_event = user.events.build(valid_event_without_user)
    expect(new_event).to be_valid
  end

  it "is not valid without user_id" do
    new_event = Event.new(valid_event_without_user)
    expect(new_event).to_not be_valid
  end
end
