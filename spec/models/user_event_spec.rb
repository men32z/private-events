# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEvent, type: :model do
  let(:creator) { User.create(name: 'Mike', email: 'mikew@monsterinc.com', password: 'wasausky') }
  let(:attendee1) { User.create(name: 'Sulley', email: 'sulley@monsterinc.com', password: 'Sullivan') }
  let(:attendee2) { User.create(name: 'Boo', email: 'boo@monsterinc.com', password: 'imababy') }
  let(:event1) { creator.events.create(name: "Costumes's Party", description: 'everyone should use a costume', date: '2005-02-17 11:52:00') }
  let(:event2) { creator.events.create(name: "Mike's Birthday", description: 'sully is going to bring the cake', date: '2025-02-17 11:52:00') }
  it 'register an Event Attendee to the Event' do
    user_registerd = UserEvent.new(user_id: attendee1.id, event_id: event1.id)
    expect(user_registerd).to be_valid
    user_registerd.save
    expect(attendee1.attended_events.count).to eq(1)
    expect(event1.attendees.count).to eq(1)

    UserEvent.create(user_id: attendee2.id, event_id: event1.id)
    expect(event1.attendees.count).to eq(2)

    UserEvent.create(user_id: attendee2.id, event_id: event2.id)
    expect(attendee2.attended_events.count).to eq(2)
  end
end
