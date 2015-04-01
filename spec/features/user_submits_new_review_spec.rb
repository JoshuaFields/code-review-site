require 'rails_helper'

feature %q(
  As an authenticated user
  I want to submit a new review for a tutorial
  so that others can know my important opinion.
) do

  before(:each) do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end

  scenario 'Submits a new review' do
    test_tutorial = FactoryGirl.create(:tutorial)
    visit tutorial_path(test_tutorial.id)
    select '4', from: 'Rating'
    fill_in 'Body', with: 'This is a totally awesome tutorial!'
    expect(page).to have_content('This is a totally awesome tutorial!')
    expect(page).to have_content('4')
  end
end
