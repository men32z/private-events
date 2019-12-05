# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session feature', type: :feature do
  let(:user_valid) do
    has_x = { name: 'mike', email: 'mikew@monsterinc.com' }
    has_x[:password] = 'wasausky'
    has_x[:password_confirmation] = 'wasausky'
    has_x
  end

  scenario 'login with form' do
    visit login_path
    expect(page).to have_content 'Log in'
    assert_selector "input[name='name']"
    assert_selector "input[name='user_id']"
    assert_selector "input[type='submit']"
  end

  scenario 'login valid with id' do
    user = User.create(user_valid)
    visit login_path

    fill_in 'name', with: user.name
    click_button 'Log in'
    expect(page).to have_content user.name
    expect(current_path).to eq(user_path(user))
  end

  scenario 'login valid with name' do
    user = User.create(user_valid)
    visit login_path

    fill_in 'user_id', with: user.id
    click_button 'Log in'
    expect(page).to have_content user.name
    expect(current_path).to eq(user_path(user))
  end

  scenario 'login invalid empty form' do
    User.create(user_valid)
    visit login_path

    click_button 'Log in'
    expect(page).to have_content 'user not found'
  end

  scenario 'login invalid wrong name' do
    user = User.create(user_valid)
    visit login_path

    fill_in 'name', with: user.name + 'asdfa'
    click_button 'Log in'
    expect(page).to have_content 'user not found'
  end

  scenario 'login invalid wrong id' do
    user = User.create(user_valid)
    visit login_path

    fill_in 'user_id', with: user.id + 5
    click_button 'Log in'
    expect(page).to have_content 'user not found'
  end

  scenario 'logout' do
    user = User.create(user_valid)
    visit login_path

    fill_in 'user_id', with: user.id
    click_button 'Log in'
    expect(current_path).to eq(user_path(user))

    find("a[href='#{logout_path}']").click

    assert_selector "a[href='#{login_path}']"
  end
end
