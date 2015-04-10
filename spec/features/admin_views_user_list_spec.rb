require "rails_helper"

feature %(
  As a God
  I want to view a list of users
  So that I can cull the weak from the herd.
) do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user, admin: false) }

  scenario "valid admin account" do
    visit new_user_session_path
    fill_in "User name", with: admin.user_name
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(user.email)
    expect(current_path).to eq users_path
  end

  scenario "not an admin" do
    visit new_user_session_path
    fill_in "User name", with: user.user_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    expect(page).to_not have_content("Users List")

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")
    expect(current_path).to eq tutorials_path
  end
end
