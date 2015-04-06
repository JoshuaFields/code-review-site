require "rails_helper"

feature %(
  As a God
  I want to be able to end all memory of my users' reviews and comments
  So that which offends my greatness shall perish from their wretched mouths
) do
  let(:test_admin) { FactoryGirl.create(:user, admin: true) }
  let(:test_user) { FactoryGirl.create(:user) }
  let(:test_review) { FactoryGirl.create(:review) }
  let(:test_tutorial) { FactoryGirl.create(:tutorial) }

  before(:each) do
    test_admin.save
    test_user.save
    test_review.save
    test_tutorial.save
  end

  scenario "Not an admin" do
    visit new_user_session_path
    fill_in "Email", with: test_user.email
    fill_in "Password", with: test_user.password

    click_button "Log in"

    visit tutorial_path(test_review.tutorial)

    expect(page).to_not have_content("Delete Tutorial")
    expect(page).to_not have_content("Delete Review")
  end

  scenario "Deletes review" do
    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    visit tutorial_path(test_review.tutorial)

    expect(page).to have_content(test_review.body)

    click_link "Delete Review"

    expect(page).to_not have_content(test_review.body)
  end

  scenario "Deletes tutorial" do
    visit new_user_session_path
    fill_in "Email", with: test_admin.email
    fill_in "Password", with: test_admin.password

    click_button "Log in"

    visit tutorial_path(test_tutorial)
    expect(page).to have_content(test_tutorial.title)

    click_link "Delete Tutorial"

    expect(page).to_not have_content(test_tutorial.title)
  end
end
