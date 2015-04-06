require "rails_helper"

feature %(
  As an admin
  I want to view a list of users
  So that I can cull the weak from the herd.
) do
  let(:test_admin) { FactoryGirl.create(:user, admin: true) }
  let(:test_user) { FactoryGirl.create(:user) }

  before(:each) do
    test_admin.save
    test_user.save
  end

  scenario "valid admin account" do
    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    click_link "Users List"
    expect(page).to have_content(test_user.email)
  end

  scenario "not an admin" do
    visit new_user_session_path
    fill_in "Email", with: test_user.email
    fill_in "Password", with: test_user.password

    click_button "Log in"

    expect(page).to_not have_content("Users List")

    visit users_path

    expect(page).to have_content("This page requires admin privileges!")
    expect(page).to_not have_content(test_admin.email)
  end
end
