require 'rails_helper'


feature 'user creates new tutorial', %Q{
  As a user
  I want to add a tutorial
  So that other users can learn about and review a cool resource
} do
  before(:each) do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'
  end

    scenario 'user wants to go back to tutorial index page' do
      first_tutorial = FactoryGirl.create(:tutorial)
      visit new_tutorial_path
      click_link 'Back'
      expect(page).to have_content(first_tutorial.title)
    end


    scenario 'user creates a new tutorial with valid information' do
      visit new_tutorial_path
      fill_in :tutorial_title, with: "A Sweet Rails Tutorial"
      fill_in :tutorial_url, with: "https://www.codeschool.com/courses/rails-for-zombies-redux"
      fill_in :tutorial_language, with: "Ruby"

      fill_in :tutorial_description, with: "Y'all should really check this out."
      fill_in :tutorial_organization, with: "Code School"
      select 'Free', from: :tutorial_cost

      click_button 'Add Tutorial'

      expect(page).to have_content('A Sweet Rails Tutorial')
    end

    scenario 'user tries to create a new tutorial with missing information' do
      visit new_tutorial_path
      fill_in :tutorial_title, with: "A Sweet Rails Tutorial"
      fill_in :tutorial_language, with: "Ruby"

      fill_in :tutorial_description, with: "Y'all should really check this out."
      fill_in :tutorial_organization, with: "Code School"
      select 'Free', from: :tutorial_cost

      click_button 'Add Tutorial'

      expect(page).to have_content("Url can't be blank")
    end
end
