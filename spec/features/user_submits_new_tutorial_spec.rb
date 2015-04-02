require "rails_helper"

feature %(
  As a user
  I want to add a tutorial
  So that other users can learn about and review a cool resource
) do
  context "user is signed in" do
    before(:each) do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end

    scenario "user wants to go back to tutorial index page" do
      first_tutorial = FactoryGirl.create(:tutorial)
      visit new_tutorial_path
      click_link "Back"
      expect(page).to have_content(first_tutorial.title)
    end

    scenario "user creates a new tutorial with valid information" do
      visit new_tutorial_path
      fill_in "Title", with: "A Sweet Rails Tutorial"
      fill_in "Url",
        with: "https://www.codeschool.com/courses/rails-for-zombies-redux"
      fill_in "Language", with: "Ruby"

      fill_in "Description", with: "Y'all should really check this out."
      fill_in "Organization", with: "Code School"
      select "Free", from: "Cost"

      click_button "Submit"

      expect(page).to have_content("A Sweet Rails Tutorial")
    end

    scenario 'user tries to create a new tutorial with missing information' do
      visit new_tutorial_path
      fill_in "Title", with: "A Sweet Rails Tutorial"
      fill_in "Language", with: "Ruby"

      fill_in "Description", with: "Y'all should really check this out."
      fill_in "Organization", with: "Code School"
      select "Free", from: "Cost"

      click_button "Submit"

      expect(page).to have_content("Url can't be blank")
    end
  end

  context "user isn't signed in" do
    scenario "user creates a new tutorial with valid information" do
      visit new_tutorial_path

      expect(page).to have_no_content("Title")
    end
  end
end
