require 'rails_helper'

feature 'user accesses tutorial creation page', %Q{
  As a user
  I want to access the new page for tutorials
  So that I can add a tutorial
} do
  before(:each) do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end

  scenario 'click on link button to new tutorial page' do
    visit tutorials_path
    click_link 'Add Tutorial'
    expect(page).to have_content('Add a Tutorial')
  end
end
