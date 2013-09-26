require 'spec_helper'

feature 'Signing up' do
  scenario 'Sign up is successful' do
    visit '/'
    click_link 'Customers'
    click_link 'User Sign Up'
    fill_in "Email", :with => "newuser@example.com"
    fill_in "Password", :with => "password", :match => :prefer_exact
    fill_in "Password confirmation", :with => "password", :match => :prefer_exact
    click_button 'Sign up'
    page.should have_content("Welcome! You have signed up successfully.")
  end
end

