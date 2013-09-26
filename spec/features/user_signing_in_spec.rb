require 'spec_helper'

feature 'Signing in' do
  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'Signing in via form' do
    visit '/'
    click_link 'Customers'
    click_link 'User Sign In'
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password456"
    click_button 'Sign in'
    page.should have_content "Signed in successfully."

  end
end

