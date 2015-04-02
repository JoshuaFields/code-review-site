require "rails_helper"

feature %(
  As a user
  I want to add a tutorial
  So that other users can learn about and review a cool resource
) do
  context "user is signed in" do
    before(:each) do
      @test_user = FactoryGirl.create(:user)

      visit new_user_session_path
      fill_in "Email", with: @test_user.email
      fill_in "Password", with: @test_user.password

      click_button "Log in"
    end

    scenario "fields are pre-populated with existing information" do
      test_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      visit edit_tutorial_path(test_tutorial)
      expect(page).to have_field(:tutorial_title, with: test_tutorial.title)
      expect(page).to have_field(:tutorial_url, with: test_tutorial.url)
      expect(page).to have_field(:tutorial_organization,
        with: test_tutorial.organization)
      #expect(page).to have_select(:tutorial_cost, selected: test_tutorial.cost)
      expect(page).to have_field(:tutorial_language,
        with: test_tutorial.language)
      expect(page).to have_field(:tutorial_description,
        with: test_tutorial.description)
    end

    scenario "user wants to go back to tutorial index page" do
      first_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      second_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      visit edit_tutorial_path(first_tutorial)
      click_link "Home"
      expect(page).to have_content(first_tutorial.title)
      expect(page).to have_content(second_tutorial.title)
    end

    scenario "user wants to go back to tutorial show page" do
      first_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      second_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      visit edit_tutorial_path(first_tutorial)
      click_link "Back"
      expect(page).to have_content(first_tutorial.title)
      expect(page).to have_no_content(second_tutorial.title)
    end

    scenario "user edits tutorial with valid information" do
      test_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      visit edit_tutorial_path(test_tutorial)
      fill_in :tutorial_title, with: "A Sweet Rails Tutorial"
      fill_in :tutorial_url,
        with: "https://www.codeschool.com/courses/rails-for-zombies-redux"
      fill_in :tutorial_language, with: "Ruby"
      fill_in :tutorial_description, with: "Y'all should really check this out."
      fill_in :tutorial_organization, with: "Code School"
      select "Free", from: :tutorial_cost

      click_button "Submit"

      expect(page).to have_content("A Sweet Rails Tutorial")
    end

    scenario 'user tries to edit tutorial with missing information' do
      test_tutorial = FactoryGirl.create(:tutorial, user: @test_user)
      visit edit_tutorial_path(test_tutorial)
      fill_in :tutorial_title, with: "A Sweet Rails Tutorial"
      fill_in :tutorial_language, with: "Ruby"
      fill_in :tutorial_url, with: nil
      fill_in :tutorial_description, with: "Y'all should really check this out."
      fill_in :tutorial_organization, with: "Code School"
      select "Free", from: :tutorial_cost

      click_button "Submit"

      expect(page).to have_content("Url can't be blank")
    end
  end

  context "user isn't signed in" do
    scenario "user tries to edit tutorial" do
      test_tutorial = FactoryGirl.create(:tutorial)
      visit edit_tutorial_path(test_tutorial)

      expect(page).to have_no_content("Organization")
    end
  end
end
