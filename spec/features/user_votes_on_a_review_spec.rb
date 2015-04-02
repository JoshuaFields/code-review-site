require 'rails_helper'

feature %q(
  As a user
  I want to vote on a tutorial's review
  So that I can voice my opinion on its usefulness
) do

  context "user is signed in" do
    before(:each) do
      user = FactoryGirl.create(:user)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Log in"
    end

    scenario 'User views a tutorial with a review' do
      testreview = FactoryGirl.create(:review)

      visit tutorial_path(testreview.tutorial)

      expect(page).to have_content(testreview.body)
      expect(page).to have_content("upvote 0 downvote")

      click_on("upvote")

      expect(page).to have_content("upvote 1 downvote")
    end
  end
end
