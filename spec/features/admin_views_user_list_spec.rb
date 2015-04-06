require "rails_helper"

feature %(
  As a God
  I want to view a list of users
  So that I can cull the weak from the herd.
) do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario "valid admin account" do
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    click_link "Users List"
    expect(page).to have_content(user.email)
  end

  scenario "not an admin" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    expect(page).to_not have_content("Users List")

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")
    expect(page).to_not have_content(admin.email)
  end
end
