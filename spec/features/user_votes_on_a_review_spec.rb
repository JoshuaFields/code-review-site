# require 'rails_helper'
#
# feature %(
#   As a user
#   I want to vote on a tutorial's review
#   So that I can voice my opinion on its usefulness
# ) do
#
#   context "user is signed in" do
#     before(:each) do
#       user = FactoryGirl.create(:user)
#
#       visit new_user_session_path
#
#       fill_in "Email", with: user.email
#       fill_in "Password", with: user.password
#
#       click_button "Log in"
#     end
#
#     scenario 'User views a tutorial with a review', js: true do
#       review = FactoryGirl.create(:review)
#
#       visit tutorial_path(review.tutorial)
#
#       expect(page).to have_content(review.body)
#       expect(page).to have_selector("#review-#{review.id}", text: "0")
#
#       find('.small-1').click_link 'upvote'
#       # click_link("upvote")
#       # page.execute_script("$('.upvote-img').click();")
#       expect(page).to have_selector("#review-#{review.id}", text: "1")
#
#       find('.small-1').click_link 'upvote'
#       # page.execute_script("$('.upvote-img').click();")
#       expect(page).to have_selector("#review-#{review.id}", text: "0")
#
#       find('.small-1').click_link 'downvote'
#       # page.execute_script("$('.downvote-img').click();")
#       expect(page).to have_selector("#review-#{review.id}", text: "-1")
#     end
#   end
# end
