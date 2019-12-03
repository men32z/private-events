require 'rails_helper'

RSpec.describe 'Session feature', type: :feature do
  let(:user_valid) {{name:"mike guasausky", email: "miky@monsteruniversity.com", password:'password', password_confirmation: 'password'}}
  let(:event_valid) {{name:"event 1", description: "nice desc.", date: Date.tomorrow}}
  scenario "basic form" do
    visit new_event_path
    assert_selector "input[name='event[name]']"
    assert_selector "textarea[name='event[description]']"
    assert_selector "input[type='submit']"
  end
  scenario "list all events" do
    user = User.create(user_valid)
    event1 = user.events.build(event_valid)
    event1.save

    visit events_path
    expect(page).to have_content event1.name
    other_event = "other__event"
    expect(page).to_not have_content other_event

    event2 = user.events.build(event_valid)
    event2.name = other_event
    event2.save
    visit events_path
    expect(page).to have_content event1.name
    expect(page).to have_content other_event

  end
  scenario "shows an individual event" do
    user = User.create(user_valid)
    event = user.events.build(event_valid)
    event.save
    visit event_path(event)
    expect(page).to have_content event.creator.name
  end

  scenario "create an event with valid information" do
    user = User.create(user_valid)
    visit login_path
    fill_in :name, with: user.name
    click_button "Log in"

    visit new_event_path
    expect do
      fill_in :event_name, with: "Event 1"
      fill_in :event_description, with: "this is a nice description"
      fill_in :event_date, with: "2005-02-17 11:52:00"
      click_button "Create Event"
    end.to change(Event, :count).by(1)
  end

  scenario "show all Event's attendees" do
    creator = User.create(user_valid)
    event = creator.events.build(event_valid)
    event.save
    attendee = User.create(name:'Sulley', email:'sulley@monsterinc.com', password:'Sullivan')
    UserEvent.create(user_id: attendee.id, event_id: event.id)
    visit event_path(event)
    expect(page).to have_content attendee.name
  end
end