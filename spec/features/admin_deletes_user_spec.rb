require "rails_helper"

feature %(
  As a God
  I want to be able to damn users' souls
  So that I can be sure their sacrifices shall please me
) do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario "Deletes user" do
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(user.email)

    click_button "delete#{user.id}"

    expect(page).to_not have_content(user.email)
  end
end
