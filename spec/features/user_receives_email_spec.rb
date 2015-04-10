require 'rails_helper'
feature %(
  As a user,
  I should receive an email when someone reviews my tutorial,
  so that I can politely respond.
) do
  before(:each) do
    user = FactoryGirl.create(:user)

    visit new_user_session_path
    fill_in "User name", with: user.user_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
  end
  scenario "review a tutorial" do
    # Clear out any previously delivered emails
    ActionMailer::Base.deliveries.clear

    test_tutorial = FactoryGirl.create(:tutorial)
    visit tutorial_path(test_tutorial.id)

    fill_in "Body", with: "Total garbage."
    select '4', from: 'Rating'

    click_button "Add Review"

    expect(page).to have_content("Total garbage.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
