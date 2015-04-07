require 'rails_helper'

feature %(
  As a user
  I want to view a specific tutorial
  So that I can learn more about it
) do
  let!(:tutorial) { FactoryGirl.create(:tutorial) }

  scenario 'user views specific tutorial' do
    visit tutorial_path(tutorial)
    expect(page).to have_content(tutorial.url)
  end

  scenario 'user wants to go back to index page' do
    visit tutorial_path(tutorial)
    expect(page).to have_content(tutorial.url)
    click_on 'Back'
    expect(page).to have_content(tutorial.title)
  end
end
