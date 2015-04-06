require "rails_helper"

feature %(
  As a God
  I want to be able to damn users' souls
  So that I can be sure their sacrifices shall please me
) do
  let!(:test_admin) { FactoryGirl.create(:user, admin: true) }
  let!(:test_user) { FactoryGirl.create(:user) }

  scenario "Deletes user" do
    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(test_user.email)

    click_button "delete#{test_user.id}"

    expect(page).to_not have_content(test_user.email)

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "Email", with: test_user.email
    fill_in "Password", with: test_user.password

    click_button "Log in"

    expect(page).to have_content("Invalid email or password.")
  end
end
