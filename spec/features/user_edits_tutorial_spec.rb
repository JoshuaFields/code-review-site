require "rails_helper"

feature %(
  As a user
  I want to add a tutorial
  So that other users can learn about and review a cool resource
) do
  context "user is signed in" do
    let(:test_user) { FactoryGirl.create(:user) }

    before(:each) do
      visit new_user_session_path
      fill_in "Email", with: test_user.email
      fill_in "Password", with: test_user.password

      click_button "Log in"
    end

    scenario "fields are pre-populated with existing information" do
      test_tut = FactoryGirl.create(:tutorial, user: test_user)
      visit edit_tutorial_path(test_tut)
      expect(page).to have_field("Title", with: test_tut.title)
      expect(page).to have_field("Url", with: test_tut.url)
      expect(page).to have_field("Organization", with: test_tut.organization)
      # expect(page).to have_select("Cost", selected: test_tut.cost)
      expect(page).to have_field("Language", with: test_tut.language)
      expect(page).to have_field("Description", with: test_tut.description)
    end

    scenario "user wants to go back to tutorial index page" do
      first_tut = FactoryGirl.create(:tutorial, user: test_user)
      second_tut = FactoryGirl.create(:tutorial, user: test_user)
      visit edit_tutorial_path(first_tut)
      click_link "Home"
      expect(page).to have_content(first_tut.title)
      expect(page).to have_content(second_tut.title)
    end

    scenario "user wants to go back to tutorial show page" do
      first_tut = FactoryGirl.create(:tutorial, user: test_user)
      second_tut = FactoryGirl.create(:tutorial, user: test_user)
      visit edit_tutorial_path(first_tut)
      click_link "Back"
      expect(page).to have_content(first_tut.title)
      expect(page).to have_no_content(second_tut.title)
    end

    scenario "user edits tutorial with valid information" do
      test_tut = FactoryGirl.create(:tutorial, user: test_user)
      visit edit_tutorial_path(test_tut)
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
      test_tut = FactoryGirl.create(:tutorial, user: test_user)
      visit edit_tutorial_path(test_tut)
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
      test_tut = FactoryGirl.create(:tutorial)
      visit edit_tutorial_path(test_tut)

      expect(page).to have_no_content("Organization")
    end
  end
end
