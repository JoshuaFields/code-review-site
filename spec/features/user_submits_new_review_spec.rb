require 'rails_helper'

feature %q(
  As an authenticated user
  I want to submit a new review for a tutorial
  so that others can know my important opinion.
) do
  scenario 'Submits a new review' do
    test_tutorial = FactoryGirl.create(:tutorial)
    sign_in test_tutorial.user
    visit tutorial_path(test_tutorial.id)
    select '4', from: 'Rating'
    fill_in 'Body', with: 'This is a totally awesome tutorial!'
    expect(page).to have_content('This is a totally awesome tutorial!')
    expect(page).to have_content('4')
  end
end
