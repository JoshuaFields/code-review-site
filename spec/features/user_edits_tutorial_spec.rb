require "rails_helper"

feature %(
  As a user
  I want to add a tutorial
  So that other users can learn about and review a cool resource
) do
  context "user is signed in" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:tutorial) { FactoryGirl.create(:tutorial, user: user) }
    let!(:second_tutorial) { FactoryGirl.create(:tutorial, user: user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end

    scenario "fields are pre-populated with existing information" do
      visit edit_tutorial_path(tutorial)
      expect(page).to have_field("Title", with: tutorial.title)
      expect(page).to have_field("Url", with: tutorial.url)
      expect(page).to have_field("Organization", with: tutorial.organization)
      # expect(page).to have_select("Cost", selected: tutorial.cost)
      expect(page).to have_field("Language", with: tutorial.language)
      expect(page).to have_field("Description", with: tutorial.description)
    end

    scenario "user wants to go back to tutorial index page" do
      visit edit_tutorial_path(tutorial)
      click_link "Home"
      expect(page).to have_content(tutorial.title)
      expect(page).to have_content(second_tutorial.title)
    end

    scenario "user wants to go back to tutorial show page" do
      visit edit_tutorial_path(tutorial)
      click_link "Back"
      expect(page).to have_content(tutorial.title)
      expect(page).to have_no_content(second_tutorial.title)
    end

    scenario "user edits tutorial with valid information" do
      visit edit_tutorial_path(tutorial)
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

    scenario 'user tries to edit tutorial with missing information' do
      visit edit_tutorial_path(tutorial)
      fill_in "Title", with: "A Sweet Rails Tutorial"
      fill_in "Language", with: "Ruby"
      fill_in "Url", with: nil
      fill_in "Description", with: "Y'all should really check this out."
      fill_in "Organization", with: "Code School"
      select "Free", from: "Cost"

      click_button "Submit"

      expect(page).to have_content("Url can't be blank")
    end
  end

  context "user isn't signed in" do
    scenario "user tries to edit tutorial" do
      tutorial = FactoryGirl.create(:tutorial)
      visit edit_tutorial_path(tutorial)

      expect(page).to have_no_content("Organization")
    end
  end
end
