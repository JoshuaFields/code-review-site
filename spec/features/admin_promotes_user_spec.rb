require "rails_helper"

feature %(
  As a God
  I want to be able to invite my fellow Gods to Mt. Olympus
  So that mortals may tremble at our presence
) do
  let!(:test_admin) { FactoryGirl.create(:user, admin: true) }
  let(:test_admin_two) { FactoryGirl.create(:user, admin: true) }
  let(:test_user) { FactoryGirl.create(:user) }

  scenario "promotes user to admin" do
    visit new_user_session_path
    fill_in "Email", with: test_user.email
    fill_in "Password", with: test_user.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    visit users_path

    click_button "toggle#{test_user.id}"

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "Email", with: test_user.email
    fill_in "Password", with: test_user.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(test_admin.email)
  end

  scenario "demotes admin to user" do
    visit new_user_session_path
    fill_in "Email", with: test_admin_two.email
    fill_in "Password", with: test_admin_two.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content(test_admin.email)

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    visit users_path

    click_button "toggle#{test_admin_two.id}"

    click_link "Sign Out"

    visit new_user_session_path
    fill_in "Email", with: test_admin_two.email
    fill_in "Password", with: test_admin_two.password

    click_button "Log in"

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")
  end
end
