require "rails_helper"

feature %(
  As a God
  I want to be able to end all memory of my users' submissions and reviews
  So that which offends my greatness shall perish from their wretched mouths
) do
  let!(:admin) { FactoryGirl.create(:user, admin: true) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:review) { FactoryGirl.create(:review) }
  let!(:tutorial) { FactoryGirl.create(:tutorial) }

  scenario "Not an admin" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"
    visit tutorial_path(review.tutorial)
    expect(page).to_not have_content("Delete Tutorial")
    expect(page).to_not have_content("Delete Review")
  end

  scenario "Deletes review" do
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit tutorial_path(review.tutorial)

    expect(page).to have_content(review.body)

    click_link "Delete Review"

    expect(page).to_not have_content(review.body)
  end

  scenario "Deletes tutorial" do
    visit new_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password

    click_button "Log in"

    visit tutorial_path(tutorial)
    expect(page).to have_content(tutorial.title)

    click_link "Delete Tutorial"

    expect(page).to_not have_content(tutorial.title)
  end
end
