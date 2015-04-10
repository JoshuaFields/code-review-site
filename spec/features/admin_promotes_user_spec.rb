require "rails_helper"

feature %(
  As a God
  I want to be able to invite my fellow Gods to Mt. Olympus
  So that mortals may tremble at our presence
) do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:admin_two) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario "promotes user to admin" do
    visit new_user_session_path
    fill_in "User name", with: admin.user_name
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit users_path

    click_button "toggle#{user.id}"

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "User name", with: user.user_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(admin.email)
  end

  scenario "demotes admin to user" do
    visit new_user_session_path
    fill_in "User name", with: admin.user_name
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit users_path

    click_button "toggle#{admin_two.id}"

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "User name", with: admin_two.user_name
    fill_in "Email", with: admin_two.email
    fill_in "Password", with: admin_two.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")
  end
end
