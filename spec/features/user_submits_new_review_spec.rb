require 'rails_helper'

feature %(
  As an authenticated user
  I want to submit a new review for a tutorial
  so that others can know my important opinion.
) do
  context "user is signed in" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:tutorial) { FactoryGirl.create(:tutorial, user: user) }

    before(:each) do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    scenario 'Submits a new review' do
      visit tutorial_path(tutorial.id)
      select '4', from: 'Rating'
      fill_in 'Body', with: 'This is a totally awesome tutorial!'

      click_button "Add Review"

      expect(page).to have_content('This is a totally awesome tutorial!')
      expect(page).to have_content('4')
    end
  end

  context "user is not signed in" do
    scenario 'Submits a new review' do
      tutorial = FactoryGirl.create(:tutorial)
      visit tutorial_path(tutorial.id)
      select '4', from: 'Rating'
      fill_in 'Body', with: 'This is a totally awesome tutorial!'

      click_button "Add Review"

      expect(page).to have_no_content('This is a totally awesome tutorial!')
      expect(page).to have_no_content('4')
    end
  end
end
