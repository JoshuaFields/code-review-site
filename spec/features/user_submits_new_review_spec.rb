require 'rails_helper'

feature %q(
  As a user
  I want to submit a new review for a tutorial
  so that others can know my important opinion.
) do
  scenario 'Submits a new review' do
    testtutorial = FactoryGirl.create(:tutorial)
    visit tutorial_path(testtutorial.id)
    select '4', from: 'Rating'
    fill_in 'Body', with: 'This is a totally awesome tutorial!'
    expect(page).to have_content('This is a totally awesome tutorial!')
  end
end