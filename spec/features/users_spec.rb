require 'rails_helper'

RSpec.describe 'User Sign up', type: :feature do
  scenario 'Sign up valid' do
    visit new_user_path
    expect(page).to have_content 'Sign Up'
    assert_selector "form[action='#{users_path}']"
    assert_selector "form[method='post']"
    assert_selector "input[name='user[name]']"
    assert_selector "input[name='user[email]']"
    assert_selector "input[name='user[password]']"
    assert_selector "input[type='submit']"
    expect do
      fill_in 'user_name', with: 'Luis Preza'
      fill_in 'user_email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Create Account'
    end.to change(User, :count).by(1)
    expect(current_path).to eql(user_path(User.last.id))
    expect(page).to have_content('User Created')
    expect(page).to have_content('Luis Preza')
  end
end