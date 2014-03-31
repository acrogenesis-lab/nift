require 'spec_helper'

feature 'user creates an account', %q{
  As a aspiring user
  I want to create an account
  so I can log-in and post and read reviews
} do

  # Acceptance criteria

  # I can enter my username, email and password
  # Email must be unique, all fields are required
  # Confirm email by responding to unique link in confirm email
  # After sign-on I get to the welcome page
  # I am prompted to re-enter my email

  scenario 'user registers with valid information' do
    count = User.count

    visit '/nifty/register'
    fill_in 'user_name', with: 'Brutus'
    fill_in 'user_email', with: 'brutus@gmail.com'
    fill_in 'user_password', with: 'b1234567'
    fill_in 'user_password_confirmation', with: 'b1234567'
    click_on 'Register'

    expect(current_path).to eq('/home')
    expect(User.count).to eq(count + 1)
  end

  scenario 'user fills out form incorrectly' do
    fields = ['User Name', 'Email', 'Password']
    visit '/nifty/register'
    click_on 'Register'
    fields.each {|field| expect(page).to have_content("#{field} can't be blank")}
  end

  scenario 'user enters an invalid password' do
    visit '/nifty/register'
    fill_in 'user_name', with: 'Brutus'
    fill_in 'user_email', with: 'brutus@gmail.com'
    fill_in 'user_password', with: 'b123'
    fill_in 'user_password_confirmation', with: 'b123'
    click_on 'Register'

    expect(page).to have_content('Password is too short')
  end
end