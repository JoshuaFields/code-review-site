require 'rails_helper'

feature %q(
  As a user
  I want to view all the reviews belonging to a tutorial
  so that I can learn if it's good or not. 
) do
  scenario 'Views tutorial show page, sees all reviews for that tutorial' do
    testreview = FactoryGirl.create(:review)
    visit tutorial_path(testreview.tutorial_id)
    expect(page).to have_content(testreview.body)
  end
end